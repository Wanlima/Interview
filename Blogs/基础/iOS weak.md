````
NSObject *obj = [[NSObject alloc] init];
id __weak weakObj = obj;
````


通过[Symbolic Breakpoint](https://blog.csdn.net/xuhen/article/details/77747456)拦截 `objc_initWeak` 方法：

![Symbolic Breakpoint](/Users/wangwanli/Desktop/Interview/Blogs/images/Symbolic Breakpoint.png)

跟踪汇编信息，可以发现底层库调了`objc_initWeak` 函数:

![Symbolic Breakpoint](/Users/wangwanli/Desktop/Interview/Blogs/images/objc_initWeak.png)

