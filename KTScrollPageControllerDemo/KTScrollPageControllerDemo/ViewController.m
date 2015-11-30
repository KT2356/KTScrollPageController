//
//  ViewController.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTScrollPageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KTScrollPageController *pageVC = [[KTScrollPageController alloc]
                                      initWithFrame:CGRectMake(0, 50, 320, 300)
                                      pageNumber:3
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
    [self.view addSubview:pageVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
