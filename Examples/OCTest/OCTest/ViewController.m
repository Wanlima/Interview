//
//  ViewController.m
//  OCTest
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import "ViewController.h"
#import "ThreadSafeTest.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [ThreadSafeTest nonatomicTest];
    
//    [ThreadSafeTest atomicTest];
}


@end
