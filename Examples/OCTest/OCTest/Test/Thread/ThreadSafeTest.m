//
//  ThreadSafeTest.m
//  OCTest
//
//  Created by Passion on 2020/5/30.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import "ThreadSafeTest.h"

@implementation ThreadSafeTest

+ (void)nonatomicTest {
    
    ThreadSafeTest *test = [[ThreadSafeTest alloc] init];
    
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            test.num1 += 1;
        });
    }
}

+ (void)atomicTest {
    ThreadSafeTest *test = [[ThreadSafeTest alloc] init];
    for (int i = 0; i < 10000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            test.num2 += 1;
        });
    }
}

@end
