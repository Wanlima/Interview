//
//  MultiThreadTest.m
//  OCTest
//
//  Created by Passion on 2020/7/3.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import "MultiThreadTest.h"

@implementation MultiThreadTest

// 同步+串行队列
+ (void)syncSerial {
    
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

// 同步+并行队列
+ (void)syncConcurrent {
    
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

// 异步+串行队列
+ (void)asyncSerial {
    
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

// 异步+并行队列
+ (void)asyncConcurrent {
    
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

@end
