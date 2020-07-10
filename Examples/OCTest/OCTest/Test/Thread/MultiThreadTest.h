//
//  MultiThreadTest.h
//  OCTest
//
//  Created by Passion on 2020/7/3.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MultiThreadTest : NSObject

// 同步+串行队列
+ (void)syncSerial;

// 同步+并行队列
+ (void)syncConcurrent;

// 异步+串行队列
+ (void)asyncSerial;

// 异步+并行队列
+ (void)asyncConcurrent;

@end

NS_ASSUME_NONNULL_END
