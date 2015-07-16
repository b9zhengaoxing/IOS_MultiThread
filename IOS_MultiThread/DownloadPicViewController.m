//
//  DownloadPicViewController.m
//  IOS_MultiThread
//
//  Created by Maculish Ting on 15/6/14.
//http://blog.csdn.net/totogo2010/article/details/8010231
//http://objccn.io/issue-2-1/

#import "DownloadPicViewController.h"
#define kURL @"http://avatar.csdn.net/2/C/D/1_totogo2010.jpg"


@interface DownloadPicViewController ()

@end

@implementation DownloadPicViewController
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createThread];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// create Thread
-(void)createThread
{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(downloadImage:) object:kURL];
    [thread start];
}

// thread
-(void)downloadImage:(NSString *) url{
    NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [[UIImage alloc]initWithData:data];
    if(image == nil){
        
    }else{
        //  主线程交互
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
    }
}

-(void)updateUI:(UIImage*) image{
    self.imageView.image = image;
}

@end
