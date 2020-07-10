Category 的结构体：

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

类别和扩展的区别？

类别为什么不能添加属性？

>我们知道 `Property` 的本质是 `成员变量+存取方法`（ivar、getter/setter），`@synthesize` 是Xcode编译器特性，它会自动生成ivar、getter/setter。
>
>dyld加载期间，类别才会被加载并`attach`到相应的类中，这是一个动态的过程，`成员变量`不能动态添加，因为表示`OC`类的结构体在运行时并不能改变。类别的结构体中虽然有属性列表，但是这些属性不会自动生成`成员变量`，自然也就不会合成存取方法，也就是不具备`@synthesize`的作用。

类别中的方法什么时候开始合并的？

**参考：**

[iOS 类别不能添加属性原理？](https://www.zhihu.com/question/51513146/answer/126443097)

[iOS Category的本质](https://www.jianshu.com/p/fa66c8be42a2)
