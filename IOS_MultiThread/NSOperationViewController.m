//
//  NSOperationViewController.m
//  IOS_MultiThread
//
//  Created by litengfei on 16/7/15.
//  Copyright (c) 2015年 LYD. All rights reserved.
//

#import "NSOperationViewController.h"
#define kURL @"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"


@interface NSOperationViewController ()

@end

@implementation NSOperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self
                                                                           selector:@selector(downloadImage:)
                                                                             object:kURL];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downloadImage:(NSString *)url{
    NSLog(@"url:%@", url);
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc]initWithContentsOfURL:nsUrl];
    UIImage * image = [[UIImage alloc]initWithData:data];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
}
-(void)updateUI:(UIImage*) image{
    self.imageView.image = image;
}

@end
