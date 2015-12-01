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


//设置分割线
- (void)setSeperatorLineColor:(UIColor *)color
                         show:(BOOL)needShownd;
//设置title
- (void)setTitleAttribute:(UIFont *)font
          backgroundColor:(UIColor *)backgroundColor
                textColor:(UIColor *)textColor
         highLightedColor:(UIColor *)highLightedColor;

//设置underLine
- (void)setTitleUnderLineColor:(UIColor *)color
                          show:(BOOL)needShown;

//设置titleView 阴影
- (void)setTitleShadowColor:(UIColor *)color
                       show:(BOOL)needShown;
@end
