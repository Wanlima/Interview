//
//  main.m
//  OCTest
//
//  Created by wang wanli on 2020/4/27.
//  Copyright © 2020 wang wanli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

__attribute__((constructor)) static void beforeMain(void) {
    NSLog(@"beforeMain");
}
__attribute__((destructor)) static void afterMain(void) {
    NSLog(@"afterMain");
}

int number = 10;

void(^block)(int) = ^(int number){
    printf("%d", number);
};

int main(int argc, char * argv[]) {
//    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
//        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        block(number);

        void(^blk)(void) = ^{
            number = 9;
        };

        blk();
    }

//    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
    return 0;
}
