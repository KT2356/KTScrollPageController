//
//  KTScrollPageController.h
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
//回调页面，加载视图
typedef void(^PageBolck)(NSMutableArray *viewArray);


@protocol KTScrollPageDelegate <NSObject>
@optional
//当前页面发生变化时，发出delegate
- (void)KTScrollPageCurrentPageDidChanged:(NSInteger)currentPageIndex;
@end


@interface KTScrollPageController : UIView
@property (nonatomic, weak) id <KTScrollPageDelegate> delegate;
//初始化
- (instancetype)initWithFrame:(CGRect)frame
                   titleName :(NSArray *)titleArray
                 setPageBlock:(PageBolck)pageBlock;
@end
