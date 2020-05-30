测试类

````
//
//  People.h
//  OCTest
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject

@property (nonatomic, assign) NSString *name;

@property (nonatomic, weak) NSString *delegate;

@end

NS_ASSUME_NONNULL_END

````

在`ViewController.m`中测试，点击屏幕打印`People`的属性值：

````
//
//  ViewController.m
//  OCTest
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import "ViewController.h"
#import "People.h"

@interface ViewController ()

@property (nonatomic, strong) People *p;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *delegate = [NSString stringWithFormat:@"abc"];
    self.p = [[People alloc] init];
    self.p.delegate = delegate;
    self.p.name = delegate;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@", self.p.delegate);
    NSLog(@"%@", self.p.name);
}

@end

````

当给`People`的实例对象的属性赋值一个很短的字符串，点击屏幕输出log：

````
2020-05-30 14:19:28.145588+0800 OCTest[22214:1185651] abc
2020-05-30 14:19:28.146099+0800 OCTest[22214:1185651] abc
````
这似乎与iOS的内存管理原则(**一个对象没有强引用，它就会被释放掉**)相违背，别激动我们继续往下看。

当给`People`的实例对象的属性赋值一个很长的字符串，修改代码：
````
 NSString *delegate = [NSString stringWithFormat:@"abcabcabcabcabc"];
````

点击屏幕输出log：

````
2020-05-30 14:17:07.196635+0800 OCTest[22185:1183980] (null)
2020-05-30 14:17:07.197014+0800 OCTest[22185:1183980] *** -[CFString retain]: message sent to deallocated instance 0x7b0c000b1450
````

出现了我们预期的结果：

1. `weak`修饰的属性在没有强引用的情况下被释放掉了；
2. `assign`修饰的属性在被释放掉之后成为野指针，再对其发送消息，程序crash了;

那么，问题来了，同样的代码，为何只是修改了字符串的长度却出现了两种不同的结果？