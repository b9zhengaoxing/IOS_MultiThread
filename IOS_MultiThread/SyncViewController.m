//
//  SyncViewController.m
//  IOS_MultiThread
//
//  Created by litengfeion 16/7/15.
//  Copyright (c) 2015年 LYD. All rights reserved.
//  参考：http://www.cnblogs.com/luoguoqiang1985/p/3495800.html

#import "SyncViewController.h"

@interface SyncViewController ()

@end

@implementation SyncViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self method1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)method
{
    static NSObject *lockObj = nil;
    
    if (lockObj == nil) {
        lockObj = [[NSObject alloc] init];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"A thread try lock!");
        @synchronized(lockObj)  {
            NSLog(@"A thread lock, please wait!");
            [NSThread sleepForTimeInterval:10];
            NSLog(@"A thread unlock!");
        }
        
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"B thread try lock!");
        @synchronized(lockObj)  {
            NSLog(@"B thread lock, please wait!");
            [NSThread sleepForTimeInterval:5];
            NSLog(@"B thread unlock!");
        }
        
    });
}

-(void)method1
{
    static NSLock *lockMain = nil;
    
    if (lockMain == nil) {
        lockMain = [[NSLock alloc] init];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lockMain lock];
        NSLog(@"A thread begin +!");
        [NSThread sleepForTimeInterval:10];
        NSLog(@"A thread + done and unlock!");
        [lockMain unlock];
        [lockMain lock];
        NSLog(@"A thread begin -!");
        [NSThread sleepForTimeInterval:10];
        NSLog(@"A thread - done and unlock!");
        [lockMain unlock];
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [lockMain lock];
        NSLog(@"B thread begin *!");
        [NSThread sleepForTimeInterval:10];
        NSLog(@"B thread * done and unlock!");
        [lockMain unlock];
        [lockMain lock];
        NSLog(@"B thread begin /!");
        [NSThread sleepForTimeInterval:10];
        NSLog(@"B thread / done and unlock!");
        [lockMain unlock];
    });
}

-(void)method2
{
    
}


@end
