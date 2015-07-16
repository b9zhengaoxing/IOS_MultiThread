//
//  GCDViewController.m
//  IOS_MultiThread
//
//  Created by litengfei on 16/7/15.
//  Copyright (c) 2015年 LYD. All rights reserved.
// 参考文章: http://blog.csdn.net/totogo2010/article/details/8016129

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self getPicture1];
    [self getPicture2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//1、常用的方法dispatch_async
//为了避免界面在处理耗时的操作时卡死，比如读取网络数据，IO,数据库读写等，我们会在另外一个线程中处理这些操作，然后通知主线程更新界面。
//用GCD实现这个流程的操作比前面介绍的NSThread  NSOperation的方法都要简单。代码框架结构如下：
-(void)getPicture1
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"];
        NSData * data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *image = [[UIImage alloc]initWithData:data];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.imageView.image = image;
            });
        }
    });
}

//2、dispatch_group_async的使用
//dispatch_group_async可以实现监听一组任务是否完成，完成后得到通知执行其他的操作。这个方法很有用，比如你执行三个下载任务，当三个任务都下载完成后你才通知界面说完成的了。下面是一段例子代码：
-(void)getPicture2
{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, queue, ^{
            [NSThread sleepForTimeInterval:1];
            NSLog(@"group1");
        });
        dispatch_group_async(group, queue, ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"group2");
        });
        dispatch_group_async(group, queue, ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"group3");
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSLog(@"updateUi");
        });

}

//3、dispatch_barrier_async的使用
//dispatch_barrier_async是在前面的任务执行结束后它才执行，而且它后面的任务等它执行完成之后才会执行
-(void)getPicture3
{
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"dispatch_async1");
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:4];
        NSLog(@"dispatch_async2");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"dispatch_barrier_async");
        [NSThread sleepForTimeInterval:4];
        
    });
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"dispatch_async3");
    });
}


@end
