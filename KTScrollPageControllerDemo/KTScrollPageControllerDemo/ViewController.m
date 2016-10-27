//
//  ViewController.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTScrollPageController.h"

@interface ViewController ()<KTScrollPageDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KTScrollPageController *pageVC = [[KTScrollPageController alloc]
                                      initWithFrame:CGRectMake(0,
                                                               0,
                                                               [UIScreen mainScreen].bounds.size.width,
                                                               [UIScreen mainScreen].bounds.size.height - 64)
                                      titleName:@[@"我的提问",@"哈哈哈哈",@"呵呵"]
                                      setPageBlock:^(NSMutableArray *viewArray) {
                                          
        UIView *text = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        text.backgroundColor = [UIColor redColor];
        [viewArray[0] addSubview:text];
        
        UIView *text2 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        text2.backgroundColor = [UIColor blackColor];
        [viewArray[1] addSubview:text2];
        
        UIView *text3 = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
        text3.backgroundColor = [UIColor greenColor];
        [viewArray[2] addSubview:text3];
    }];
    pageVC.delegate = self;
    [self.view addSubview:pageVC];
}

- (void)KTScrollPageCurrentPageDidChanged:(NSInteger)currentPageIndex {
    NSLog(@"%ld",(long)currentPageIndex);
}

@end
