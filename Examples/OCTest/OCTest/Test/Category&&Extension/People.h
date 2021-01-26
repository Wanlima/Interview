//
//  People.h
//  OCTest
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface People : NSObject

@property (nonatomic, assign) NSString *name;

@property (nonatomic, weak) NSString *delegate;

- (void)run;

@end

NS_ASSUME_NONNULL_END
