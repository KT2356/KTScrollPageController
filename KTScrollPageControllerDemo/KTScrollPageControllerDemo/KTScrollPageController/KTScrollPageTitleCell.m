//
//  KTScrollPageTitleCell.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/12/1.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTScrollPageTitleCell.h"
#import <Masonry.h>

@interface KTScrollPageTitleCell()
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView  *seperatorView;
@end

@implementation KTScrollPageTitleCell

#pragma mark - public methods

- (void)bindWithTitle:(NSString *)title showSeperator:(BOOL)show {
    self.titleLabel.text      = title;
    self.seperatorView.hidden = show;
}

#pragma mark - override
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
   self.titleLabel.textColor = selected ? [UIColor orangeColor] : [UIColor blackColor];
}


#pragma mark - setter/getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
    return _titleLabel;
}

- (UIView *)seperatorView {
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 10)];
        _seperatorView.backgroundColor = [UIColor blackColor];
        [self addSubview:_seperatorView];
        
        [_seperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1/[UIScreen mainScreen].scale);
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(@20);
        }];
    }
    return _seperatorView;
}

@end
