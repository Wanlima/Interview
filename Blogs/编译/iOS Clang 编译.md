#####将`OC`代码翻译成`C++`代码：

````
$xcrun -sdk iphoneos clang -arch arm64 -framework UIKit -rewrite-objc main.m -o main.cpp
````

*  -sdk iphoneos 指定平台，也可以是模拟器`iphonesimulator `
*  -arch arm64 指定`CPU`架构
*  -framework UIKit 指定引用的框架

#####clang编译弱引用`__weak`失败：

````
NSObject *obj = [[NSObject alloc] init];
__weak NSObject *weakObj = obj;
````


> error: cannot create __weak reference because the current deployment target does not support weak references __attribute__((objc_ownership(weak))) NSObject *weakObj = obj;

`__weak` 需要运行时环境的支持，添加 `-fobjc-arc` 和 `-fobjc-runtime=ios-9.0.0` 两个参数即可：

````
$ xcrun -sdk iphoneos clang -arch arm64 -framework UIKit -rewrite-objc -fobjc-arc -fobjc-runtime=ios-9.0.0 main.m -o main.cpp
````