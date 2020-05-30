//
//  ThreadSafeTest.h
//  OCTest
//
//  Created by Passion on 2020/5/30.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThreadSafeTest : NSObject

@property (nonatomic, assign) NSInteger num1;

@property (atomic, assign) NSInteger num2;

+ (void)nonatomicTest;

+ (void)atomicTest;

@end

NS_ASSUME_NONNULL_END
