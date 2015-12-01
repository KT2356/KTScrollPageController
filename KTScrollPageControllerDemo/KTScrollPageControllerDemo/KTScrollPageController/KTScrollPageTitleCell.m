//
//  KTScrollPageTitleCell.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/12/1.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTScrollPageTitleCell.h"

@implementation KTScrollPageTitleCell
- (void)showSeperatorLine:(BOOL)show {
    self.seperatorView.hidden = show ? NO : YES;
}

@end
