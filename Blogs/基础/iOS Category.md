在类别中添加属性：

````
@interface People (Category)

@property (nonatomic, copy) NSString *sname;

@end

````

在调用属性的`setter`和`getter`方法时会 **Crash** ：

````
OCTest[18213:2605018] -[People setSname:]: unrecognized selector sent to instance 0x7b080007be00

OCTest[18339:2610326] -[People sname]: unrecognized selector sent to instance 0x7b080007c0c0
````

**类别为什么不能添加属性？**

看一下 `Category` 的结构体：

````
struct category_t {
    const char *name;
    classref_t cls;
    struct method_list_t *instanceMethods;
    struct method_list_t *classMethods;
    struct protocol_list_t *protocols;
    struct property_list_t *instanceProperties;
    // Fields below this point are not always present on disk.
    struct property_list_t *_classProperties;
};
````

分类结构体包含 类名、cls、实例方法列表、类方法列表、协议列表、属性列表。

>我们知道 `Property` 的本质是 `成员变量+存取方法`（ivar、getter/setter），`@synthesize` 是Xcode编译器特性，它会自动生成ivar、getter/setter。
>
>dyld加载期间，类别才会被加载并`attach`到相应的类中，这是一个动态的过程，`成员变量`不能动态添加，因为表示`OC`类的结构体在运行时并不能改变。类别的结构体中虽然有属性列表，但是这些属性不会自动生成`成员变量`，自然也就不会合成存取方法，也就是不具备`@synthesize`的作用。

**分类的作用：**

>不改变原有类，给这个类扩展方法。

**类别和扩展的区别？**

两者的区别：

* 分类是运行时决议，扩展是编译时决议；
* 分类可以添加方法，通过关联对象添加成员变量，扩展可以添加属性。
* 分类既有声明头文件也有实现文件，扩展只有声明头文件，实现在类的.m文件中；

**类别中的方法什么时候开始合并的？**

> 分类是在运行时将方法列表与类的原有方法列表合并，且分类中的方法在前。


**参考：**

[iOS 类别不能添加属性原理？](https://www.zhihu.com/question/51513146/answer/126443097)

[iOS Category的本质](https://www.jianshu.com/p/fa66c8be42a2)

[Category原理](https://www.jianshu.com/writer#/notebooks/23278598/notes/31347042/preview)

