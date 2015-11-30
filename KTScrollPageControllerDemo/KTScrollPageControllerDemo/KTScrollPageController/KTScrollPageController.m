//
//  KTScrollPageController.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTScrollPageController.h"
@interface KTScrollPageController()
@property (nonatomic, strong) NSMutableArray *viewArray;
@end
@implementation KTScrollPageController



- (instancetype)initWithFrame:(CGRect)frame
                   pageNumber:(NSInteger)pageNumber
                 setPageBlock:(PageBolck) pageBlock {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSelfView];
        [self setViewArray:self.viewArray
                 WithFrame:frame
                pageNumber:pageNumber];
        pageBlock(self.viewArray);
    }
    return self;
}

- (void)setupSelfView {
    self.backgroundColor = [UIColor clearColor];
    self.pagingEnabled   = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
}


- (void)setViewArray:(NSArray *)viewArray
           WithFrame:(CGRect)frame
          pageNumber:(NSInteger)pageNumber {
    self.contentSize = CGSizeMake(frame.size.width * pageNumber, frame.size.height);
    for (int i = 0; i < pageNumber; i ++) {
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(0 + frame.size.width * i,
                                                                    0,
                                                                    frame.size.width,
                                                                    frame.size.height)];
        pageView.backgroundColor = [UIColor grayColor];
        [self addSubview:pageView];
        [self.viewArray addObject:pageView];
    }
}

- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}
@end
