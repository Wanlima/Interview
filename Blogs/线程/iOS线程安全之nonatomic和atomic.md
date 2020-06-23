**测试类**

````
//
//  ThreadSafeTest.h
//  OCTest
//
//  Created by Passion on 2020/5/30.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadSafeTest : NSObject

@property (nonatomic, assign) NSInteger num1;

@property (atomic, assign) NSInteger num2;


@end

NS_ASSUME_NONNULL_END

````

**查看`nonatomic `和`atomic `的区别：**

运行第一个`nonatomic`测试用例：

````

+ (void)nonatomicTest {
    
    ThreadSafeTest *test = [[ThreadSafeTest alloc] init];
    
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            test.num1 += 1;
        });
    }
}
````
会发现日志输入一下警告：

````
==================
WARNING: ThreadSanitizer: data race (pid=23326)
  Read of size 8 at 0x7b080007cf88 by thread T7:
2020-05-30 15:31:58.900940+0800 OCTest[23326:1224497] i：11 ---- num1：10
    #0 <null> <null> (OCTest:x86_64+0x100002715)
    #1 <null> <null> (OCTest:x86_64+0x100002243)
    #2 <null> <null> (libclang_rt.tsan_iossim_dynamic.dylib:x86_64+0x6f53b)
    #3 <null> <null> (libdispatch.dylib:x86_64+0x2e8d)

  Previous write of size 8 at 0x7b080007cf88 by thread T2:
    #0 <null> <null> (OCTest:x86_64+0x100002799)
    #1 <null> <null> (OCTest:x86_64+0x10000227b)
    #2 <null> <null> (libclang_rt.tsan_iossim_dynamic.dylib:x86_64+0x6f53b)
    #3 <null> <null> (libdispatch.dylib:x86_64+0x2e8d)

  Location is heap block of size 32 at 0x7b080007cf80 allocated by main thread:
    #0 <null> <null> (libclang_rt.tsan_iossim_dynamic.dylib:x86_64+0x4dda2)
    #1 <null> <null> (libobjc.A.dylib:x86_64+0x150c5)
    #2 <null> <null> (OCTest:x86_64+0x100001c85)
2020-05-30 15:31:58.901278+0800 OCTest[23326:1224497] i：12 ---- num1：11
    #3 <null> <null> (UIKitCore:x86_64+0x437ac1)
    #4 <null> <null> (libdyld.dylib:x86_64+0x11fc)

  Thread T7 (tid=1224504, running) is a GCD worker thread

  Thread T2 (tid=1224497, running) is a GCD worker thread

SUMMARY: ThreadSanitizer: data race (/Users/Passion/Library/Developer/CoreSimulator/Devices/75D62ECF-1AB0-41B6-8DD8-C502EB57428F/data/Containers/Bundle/Application/5E14BA51-A7A4-4944-BABC-E18D737E74E1/OCTest.app/OCTest:x86_64+0x100002715) 
==================
````

日志信息说明的很清楚了，出现了 `Data Race` 问题，字面意思就是`数据竞争`，由于`num1`不是原子性，有可能导致多个线程同时访问`setter`方法，从而导致`_num1`变量被释放多次。

`Data Race`的问题非常难查，`Data Race`一旦发生，结果是不可预期的，也许直接就`Crash`了，也许导致执行流程错乱了，也许把内存破坏导致之后某个时刻突然`Crash`了。我们可以借助Xcode的 [Thread Sanitizer](https://developer.apple.com/videos/play/wwdc2016/412) 线程检查工具 和 `Analyze` 静态分析来检查这种问题。


接下来我们把属性修改为`atomic`，再多运行几次：

````
+ (void)atomicTest {
    ThreadSafeTest *test = [[ThreadSafeTest alloc] init];
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            test.num2 += 1;
        });
    }
}
````

无论运行多少次，都不会出现上面的警告。


**老生常谈的问题：`atomic`修饰的属性绝对安全吗？**

这么问答案显然是否定的，`atomic`只能保证`setter`、`getter`方法的线程安全，并不能保证数据安全。

看一个例子：

````
+ (void)test {
    ThreadSafeTest *test = [[ThreadSafeTest alloc] init];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10000; i++) {
            test.num2 = test.num2 + 1;
            NSLog(@"循环一：i：%d ---- num2：%ld", i, (long)test.num2);
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10000; i++) {
            test.num2 = test.num2 + 1;
            NSLog(@"循环二：i：%d ---- num2：%ld", i, (long)test.num2);
        }
    });
}

````

通过打印日志可以看出两个循环穿插执行，最终输入的结果也不是我们期望值`20000`，因此`atomic`并不能保证数据安全。

那么如何保证数据安全呢？对我们的代码进行修改：

````
+ (void)test {
    
    ThreadSafeTest *test = [[ThreadSafeTest alloc] init];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (test) {
            for (int i = 0; i < 10000; i++) {
                test.num2 += 1;
                NSLog(@"i：%d ---- num2：%ld", i, (long)test.num2);
            }
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (test) {
            for (int i = 0; i < 10000; i++) {
                test.num2 += 1;
                NSLog(@"i：%d ---- num2：%ld", i, (long)test.num2);
            }
        }
    });
}
````
这个时候日志打印的结果就是20000。我们通过对`test`对象加锁，加大锁的粒度，这样就可以保证数据的安全了。

**参考：**

[WWDC 2016 Session 412](https://developer.apple.com/videos/play/wwdc2016/412/)

[如何避免数据竞争(Data race)](https://www.jianshu.com/p/0084b625fa23)