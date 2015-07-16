//
//  SynchronizationViewController.m
//  IOS_MultiThread
//
//  Created by Maculish Ting on 16/7/15.
//  Copyright (c) 2015年 LYD. All rights reserved.
//

#import "SynchronizationViewController.h"

@interface SynchronizationViewController ()

@end

@implementation SynchronizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tickets = 100;
    count = 0;
    theLock = [[NSLock alloc] init];
    // 锁对象
    ticketsCondition = [[NSCondition alloc] init];
    ticketsThreadone = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadone setName:@"Thread-1"];
    [ticketsThreadone start];
    
    ticketsThreadtwo = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [ticketsThreadtwo setName:@"Thread-2"];
    [ticketsThreadtwo start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)run{
    while (TRUE) {
        // 上锁
        //        [ticketsCondition lock];
        [theLock lock];
        if(tickets >= 0){
            [NSThread sleepForTimeInterval:0.09];
            count = 100 - tickets;
            NSLog(@"当前票数是:%d,售出:%d,线程名:%@",tickets,count,[[NSThread currentThread] name]);
            tickets--;
        }else{
            break;
        }
        [theLock unlock];
        //        [ticketsCondition unlock];
    }
}

@end
