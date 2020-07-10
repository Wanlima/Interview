**同步串行队列：**

````
// 同步+串行队列
- (void)syncSerial {
    
    dispatch_queue_t queue = dispatch_queue_create("QUEUE", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        NSLog(@"任务一：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务二：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务三：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务四：%@", [NSThread currentThread]);
    });
}
````

控制台打印结果：

````
OCTest[12025:941910] 任务一：<NSThread: 0x7b1000001100>{number = 1, name = main}
OCTest[12025:941910] 任务二：<NSThread: 0x7b1000001100>{number = 1, name = main}
OCTest[12025:941910] 任务三：<NSThread: 0x7b1000001100>{number = 1, name = main}
OCTest[12025:941910] 任务四：<NSThread: 0x7b1000001100>{number = 1, name = main}

````
**同步并行队列：**

````
// 同步+并行队列
- (void)syncConcurrent {
    
    dispatch_queue_t queue = dispatch_queue_create("QUEUE", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        NSLog(@"任务一：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务二：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务三：%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"任务四：%@", [NSThread currentThread]);
    });
}
````
控制台打印结果：

````
OCTest[12049:944311] 任务一：<NSThread: 0x7b1000001100>{number = 1, name = main}
OCTest[12049:944311] 任务二：<NSThread: 0x7b1000001100>{number = 1, name = main}
OCTest[12049:944311] 任务三：<NSThread: 0x7b1000001100>{number = 1, name = main}
OCTest[12049:944311] 任务四：<NSThread: 0x7b1000001100>{number = 1, name = main}
````

**异步串行队列：**

````
// 异步+串行队列
- (void)asyncSerial {
    
    dispatch_queue_t queue = dispatch_queue_create("QUEUE", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        NSLog(@"任务一：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务二：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务三：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务四：%@", [NSThread currentThread]);
    });
}
````
控制台打印结果：

````
OCTest[12064:945409] 任务一：<NSThread: 0x7b1000044180>{number = 6, name = (null)}
OCTest[12064:945409] 任务二：<NSThread: 0x7b1000044180>{number = 6, name = (null)}
OCTest[12064:945409] 任务三：<NSThread: 0x7b1000044180>{number = 6, name = (null)}
OCTest[12064:945409] 任务四：<NSThread: 0x7b1000044180>{number = 6, name = (null)}

````

**异步并行队列：**

````
// 异步+并行队列
- (void)asyncConcurrent {
    
    dispatch_queue_t queue = dispatch_queue_create("QUEUE", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"任务一：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务二：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务三：%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务四：%@", [NSThread currentThread]);
    });
}

````
控制台打印结果：

````
OCTest[12075:946450] 任务三：<NSThread: 0x7b1000040200>{number = 6, name = (null)}
OCTest[12075:946448] 任务一：<NSThread: 0x7b100004b340>{number = 4, name = (null)}
OCTest[12075:946454] 任务二：<NSThread: 0x7b100004a7c0>{number = 5, name = (null)}
OCTest[12075:946450] 任务四：<NSThread: 0x7b1000040200>{number = 6, name = (null)}

````
**总结：**

||串行|并行|
|:-----:|:-----:|:-----:|
|同步|不开辟线程|不开辟线程|
|异步|开辟一条线程|开辟多条线程|