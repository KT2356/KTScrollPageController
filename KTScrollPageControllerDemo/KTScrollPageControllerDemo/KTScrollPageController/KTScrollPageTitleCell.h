//
//  KTScrollPageTitleCell.h
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/12/1.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KTScrollPageTitleCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *seperatorView;

- (void)showSeperatorLine:(BOOL)show;
@end
