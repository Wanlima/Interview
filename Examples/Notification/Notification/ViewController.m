//
//  ViewController.m
//  Notification
//
//  Created by wang wanli on 2021/1/20.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler) name:@"234" object:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[NSNotificationCenter defaultCenter] postNotificationName:@"234" object:nil];


    [[NSNotificationQueue defaultQueue] enqueueNotification:[NSNotification notificationWithName:@"234" object:nil] postingStyle:NSPostWhenIdle coalesceMask:NSNotificationNoCoalescing forModes:@[NSRunLoopCommonModes]];


    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {

        }];

        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        [[NSNotificationQueue defaultQueue] enqueueNotification:[NSNotification notificationWithName:@"234" object:nil] postingStyle:NSPostWhenIdle coalesceMask:NSNotificationNoCoalescing forModes:@[NSRunLoopCommonModes]];
        [[NSRunLoop currentRunLoop] run];
    });
}


- (void)notificationHandler {
    NSLog(@"%@", [NSThread currentThread]);
}



@end
