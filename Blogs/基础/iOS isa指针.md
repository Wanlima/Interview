######12. 讲一下对象，类对象，元类，根元类结构体的组成以及他们是如何相关联的？

![](https://upload-images.jianshu.io/upload_images/723261-83003d9ead810502.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`-(Class)class`;、`+(Class)class`;、`objc_getClass()`、

`object_getClass` 的区别：

````
NSObject *obj = [NSObject new];

// 类对象
NSLog(@"通过 -(Class)class 获取类对象 -> %p", [obj class]);
// 通过类名获取类对象
const char * name = "NSObject";
NSLog(@"通过 objc_getClass 获取类对象 -> %p", objc_getClass(name));
/*
  1. 当obj为实例对象时返回它的类对象;
  2. 当obj为类对象时返回其元类对象;
  3. 当obj为元类对象时返回其根元类对象;
  4. 当obj为根元类对象时返回其本身;
 */
Class classObj = object_getClass(obj);
NSLog(@"通过 object_getClass 获取类对象 ->%p",  classObj);

// 元类对象
Class metaObj = object_getClass(classObj);
NSLog(@"通过 object_getClass 获取元类对象 -> %p",  metaObj);
NSLog(@"通过 +(Class)class 获取元类对象 -> %p",  object_getClass([NSObject class]));

 // 根元类对象
Class rootObj = object_getClass(metaObj);
NSLog(@"根元类对象 -> %p",  rootObj);
````
打印的log日志：

````
2020-05-08 10:53:48.003015+0800 Demo[16533:186763] 通过 -(Class)class 获取类对象 -> 0x7fff89be2d00
2020-05-08 10:53:48.003193+0800 Demo[16533:186763] 通过 objc_getClass 获取类对象 -> 0x7fff89be2d00
2020-05-08 10:53:48.003353+0800 Demo[16533:186763] 通过 object_getClass 获取类对象 ->0x7fff89be2d00
2020-05-08 10:53:48.003492+0800 Demo[16533:186763] 通过 object_getClass 获取元类对象 -> 0x7fff89be2cd8
2020-05-08 10:53:48.003563+0800 Demo[16533:186763] 通过 +(Class)class 获取元类对象 -> 0x7fff89be2cd8
2020-05-08 10:53:48.003636+0800 Demo[16533:186763] 根元类对象 -> 0x7fff89be2cd8
````
>它们的本质都是获取`isa`指针，打印结果也正好印证了上图isa指针的指向关系。


#####为什么对象方法没有保存到对象结构体里，而是保存在类对象的结构体里？