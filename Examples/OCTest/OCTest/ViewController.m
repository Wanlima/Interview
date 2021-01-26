//
//  ViewController.m
//  OCTest
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import "ViewController.h"
#import "ThreadSafeTest.h"
#import "People.h"
#import "People+Category.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str1 = [NSString stringWithFormat:@"abc"];
    
    NSString *str2 = [NSString stringWithFormat:@"这是一个测试字符串"];
    
    NSString *str3 = @"这是一个测试字符串";
    
    NSString *str4 = [[NSString alloc] initWithString: str3];
    
    NSLog(@"%p %p", &str1, str1);
    
    NSLog(@"class: %@ p: %p", [str1 class], str1);
    
    NSLog(@"class: %@ p: %p", [str2 class], str2);
    
    NSLog(@"class: %@ p: %p", [str3 class], str3);

    NSLog(@"class: %@ p: %p", [str4 class], str4);

    People *p = [[People alloc] init];
    [p run];
    id __weak weakObj = p;
}

@end
