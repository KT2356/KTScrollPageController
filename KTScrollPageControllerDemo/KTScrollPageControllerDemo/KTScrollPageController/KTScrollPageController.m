//
//  KTScrollPageController.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//
#define kKTScrollPageTitleHight 40

#import "KTScrollPageController.h"
#import "KTScrollPageTitleCell.h"

@interface KTScrollPageController()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    float _cellWidth;
    UIColor *_titleColor;
    UIColor *_seperatorColor;
    UIColor * _titleHighLightColor;
    UIColor *_titleUnderLineColor;
    UIFont  *_titleFont;
    BOOL    _showSeperator;
}
@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *titleLineScrollView;
@property (nonatomic, strong) UICollectionView *titleCollectionView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) NSInteger selectedIndex;

@end
@implementation KTScrollPageController


#pragma mark - public methods
- (instancetype)initWithFrame:(CGRect)frame
                   titleName :(NSArray *)titleArray
                 setPageBlock:(PageBolck) pageBlock {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupInitialValue];
        self.titleArray = titleArray;
        [self setViewArray:self.viewArray
                 WithFrame:frame
                pageNumber:self.titleArray.count];
        pageBlock(self.viewArray);
        [self.titleView addSubview:self.titleCollectionView];
        [self.titleCollectionView addSubview:self.titleLineScrollView];
    }
    return self;
}

- (void)refreshView {
    [_titleCollectionView reloadData];
}

- (void)setSeperatorLineColor:(UIColor *)color
                         show:(BOOL)needShownd{
    _seperatorColor = color;
    _showSeperator  = needShownd;
}

- (void)setTitleAttribute:(UIFont *)font
                textColor:(UIColor *)textColor
         highLightedColor:(UIColor *)highLightedColor {
    _titleColor          = textColor;
    _titleFont           = font;
    _titleHighLightColor = highLightedColor;
}

- (void)setTitleUnderLineColor:(UIColor *)color {
    _titleUnderLineColor = color;
}


#pragma mark - private methods
- (void)setupInitialValue {
    _seperatorColor      = [UIColor lightGrayColor];
    _titleColor          = [UIColor blackColor];
    _titleHighLightColor = [UIColor orangeColor];
    _titleUnderLineColor = [UIColor orangeColor];
    _titleFont           = [UIFont systemFontOfSize:16];
    _showSeperator       = YES;
}

/**
 *  @author KT, 2015-12-01 13:58:05
 *
 *  生成子视图
 *
 */
- (void)setViewArray:(NSArray *)viewArray
           WithFrame:(CGRect)frame
          pageNumber:(NSInteger)pageNumber {
    self.scrollView.contentSize = CGSizeMake(frame.size.width * pageNumber, 0);
    for (int i = 0; i < pageNumber; i ++) {
        UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(0 + frame.size.width * i,
                                                                    0,
                                                                    self.bounds.size.width,
                                                                    self.bounds.size.height - kKTScrollPageTitleHight)];
        pageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.scrollView addSubview:pageView];
        [self.viewArray addObject:pageView];
    }
}

#pragma mark - UICollectionDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_cellWidth, self.titleCollectionView.frame.size.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KTScrollPageTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KTScrollPageTitleCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.titleLabel.textColor = indexPath.row  == _selectedIndex ? _titleHighLightColor : _titleColor;
    
    cell.seperatorView.backgroundColor   = _seperatorColor;
    cell.seperatorView.hidden            = !_showSeperator;
    if (_showSeperator) {
        cell.seperatorView.hidden = indexPath.row == self.titleArray.count - 1 ? YES : NO;
    }
    cell.titleLabel.font                 = _titleFont;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self scrollContentWithTitleTapped:indexPath.row];
}

- (void)scrollContentWithTitleTapped:(NSInteger)index {
    _selectedIndex = index;
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.bounds.size.width, 0) animated:YES];
    [self.titleLineScrollView setContentOffset:CGPointMake((self.titleArray.count - 1 - index) * _cellWidth, 0) animated:YES];
    [_titleCollectionView reloadData];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _selectedIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    [self.titleLineScrollView setContentOffset:CGPointMake((self.titleArray.count - 1 - _selectedIndex) * _cellWidth, 0) animated:YES];
    [_titleCollectionView reloadData];
}

#pragma makr - setter/getter
- (NSMutableArray *)viewArray {
    if (!_viewArray) {
        _viewArray = [[NSMutableArray alloc] init];
    }
    return _viewArray;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                     kKTScrollPageTitleHight,
                                                                     self.bounds.size.width,
                                                                     self.bounds.size.height - kKTScrollPageTitleHight)];
        _scrollView.backgroundColor                = [UIColor clearColor];
        _scrollView.pagingEnabled                  = YES;
        _scrollView.showsVerticalScrollIndicator   = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.opaque                         = YES;
        _scrollView.delegate                       = self;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kKTScrollPageTitleHight)];
        _titleView.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleView];
    }
    return _titleView;
}

- (UIScrollView *)titleLineScrollView {
    if (!_titleLineScrollView) {
        _titleLineScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _titleView.frame.size.height  - kKTScrollPageTitleHight/13, self.bounds.size.width, kKTScrollPageTitleHight/13)];
        float titleWidth = self.bounds.size.width / self.titleArray.count;
        _titleLineScrollView.contentSize = CGSizeMake(titleWidth * self.viewArray.count * 2 - 1, 0);
        UIView *titleUnderLine = [[UIView alloc] initWithFrame:CGRectMake(titleWidth * (self.viewArray.count- 1) , _titleView.frame.origin.y, titleWidth, _titleLineScrollView.bounds.size.height)];
        titleUnderLine.backgroundColor                      = _titleUnderLineColor;
        _titleLineScrollView.showsHorizontalScrollIndicator = NO;
        _titleLineScrollView.scrollEnabled                  = NO;
        [_titleLineScrollView setContentOffset:CGPointMake(titleWidth * (self.viewArray.count- 1) , 0)];
        [_titleLineScrollView addSubview:titleUnderLine];
    }
    return _titleLineScrollView;
}

- (UICollectionView *)titleCollectionView {
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing      = 0;
        
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, _titleView.frame.size.height) collectionViewLayout:layout];

         [_titleCollectionView registerNib:[UINib nibWithNibName:@"KTScrollPageTitleCell" bundle:nil] forCellWithReuseIdentifier:@"KTScrollPageTitleCell"];
        _cellWidth = _titleCollectionView.frame.size.width / self.titleArray.count;
        _titleCollectionView.scrollEnabled                  = NO;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
        _titleCollectionView.delegate                       = self;
        _titleCollectionView.dataSource                     = self;
        _titleCollectionView.backgroundColor                = [UIColor clearColor];
    }
    return _titleCollectionView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSArray alloc] init];
    }
    return  _titleArray;
}

@end
