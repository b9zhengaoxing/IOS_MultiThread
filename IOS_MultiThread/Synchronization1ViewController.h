//
//  Synchronization1ViewController.h
//  IOS_MultiThread
//
//  Created by litengfei on 16/7/15.
//  Copyright (c) 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Synchronization1ViewController : UIViewController
{
    int tickets;
    int count;
    NSThread* ticketsThreadone;
    NSThread* ticketsThreadtwo;
    NSCondition* ticketsCondition;
    NSLock *theLock;
}

@end
