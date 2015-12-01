//
//  KTScrollPageController.h
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PageBolck)(NSMutableArray *viewArray);
@interface KTScrollPageController : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   titleName :(NSArray *)titleArray
                 setPageBlock:(PageBolck)pageBlock;


- (void)setSeperatorLineColor:(UIColor *)color
                         show:(BOOL)needShownd;

- (void)setTitleAttribute:(UIFont *)font
                textColor:(UIColor *)textColor
         highLightedColor:(UIColor *)highLightedColor;

- (void)setTitleUnderLineColor:(UIColor *)color;

/**
 *  @author KT, 2015-12-01 13:56:22
 *
 *  刷新title，每次设置title属性后需要调用
 */
- (void)refreshView;

@end
