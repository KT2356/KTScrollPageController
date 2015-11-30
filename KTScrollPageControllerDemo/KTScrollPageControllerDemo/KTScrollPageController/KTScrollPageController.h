//
//  KTScrollPageController.h
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PageBolck)(NSMutableArray *viewArray);
@interface KTScrollPageController : UIScrollView
- (instancetype)initWithFrame:(CGRect)frame
                   pageNumber:(NSInteger)pageNumber
                 setPageBlock:(PageBolck) pageBlock;
@end
