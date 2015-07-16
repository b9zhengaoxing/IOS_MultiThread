//
//  SynchronizationViewController.h
//  IOS_MultiThread
//
//  Created by Maculish Ting on 16/7/15.
//  Copyright (c) 2015年 LYD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SynchronizationViewController : UIViewController
{
    int tickets;
    int count;
    NSThread* ticketsThreadone;
    NSThread* ticketsThreadtwo;
    NSCondition* ticketsCondition;
    NSLock *theLock;
}

@end
