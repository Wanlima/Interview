**weak 和 assign的区别：**

在`ViewController.m`中测试，点击屏幕打印`People`的属性值：

````

@interface ViewController ()

@property(nonatomic, weak) NSString * weakString;

@property(nonatomic, assign) NSString * assignString;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    NSString *str = [NSString stringWithFormat:@"这是一个测试字符串"];
    self.weakString = str;
    self.assignString = str;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.weakString);
    NSLog(@"%@", self.assignString);
}

@end

````

点击屏幕输出log：

````
2020-05-30 14:17:07.196635+0800 OCTest[22185:1183980] (null)
2020-05-30 14:17:07.197014+0800 OCTest[22185:1183980] *** -[CFString retain]: message sent to deallocated instance 0x7b0c000b1450
````

> `weak`修饰的属性在没有强引用的情况下被释放掉且指针设为`nil`，`assign`修饰的属性在被释放掉之后指针没有设为`nil`，成为野指针，再对其发送消息，程序crash了。


**总结：**

* `weak` 只能修饰 `OC` 对象，`assign` 既能修饰 `OC` 对象，也能修饰基本类型；
* `weak` 修饰的对象会被放到全局的哈希表中，对象没有强引用时会自动将指针置为`nil`，不需要关心它的内存管理，`assign` 修饰基本类型时，内存被分配在栈上，由系统负责管理栈内存，在修饰引用类型会被放入堆中，需要我们自己手动管理内存或通过ARC管理。
* `weak` 修饰的对象在内存释放后指针会置为 `nil`，`assign` 不会，从而需要注意野指针的问题；