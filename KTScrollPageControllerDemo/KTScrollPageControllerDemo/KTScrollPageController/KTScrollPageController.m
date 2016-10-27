//
//  KTScrollPageController.m
//  KTScrollPageControllerDemo
//
//  Created by KT on 15/11/30.
//  Copyright © 2015年 KT. All rights reserved.
//
#import "KTScrollPageController.h"
#import "KTScrollPageTitleCell.h"

static const float kKTScrollPageTitleHight = 40.0f;

@interface KTScrollPageController()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    float _cellWidth;
}
@property (nonatomic, strong) NSMutableArray *viewArray;            //用于回调的view
@property (nonatomic, strong) UIView *titleView;                    //标题背景
@property (nonatomic, strong) UIScrollView *scrollView;             //滚动主视图
@property (nonatomic, strong) UIScrollView *titleLineScrollView;    //下划线滚动视图
@property (nonatomic, strong) UICollectionView *titleCollectionView;//标题视图
@property (nonatomic, strong) NSArray *titleArray;                  //存放标题数组
@property (nonatomic, assign) NSInteger selectedIndex;              //当前选中
@end
@implementation KTScrollPageController

#pragma mark - public methods
- (instancetype)initWithFrame:(CGRect)frame
                   titleName :(NSArray *)titleArray
                 setPageBlock:(PageBolck) pageBlock {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArray = titleArray;
        [self setViewArray:self.viewArray
                 WithFrame:frame
                pageNumber:self.titleArray.count];
        if (pageBlock) {
            pageBlock(self.viewArray);
        }
        
        [self.titleView addSubview:self.titleCollectionView];
        [self.titleCollectionView addSubview:self.titleLineScrollView];
    }
    return self;
}

#pragma mark - private methods
- (void)setupDelegate {
    if ([self.delegate respondsToSelector:@selector(KTScrollPageCurrentPageDidChanged:)]) {
        [self.delegate KTScrollPageCurrentPageDidChanged:_selectedIndex];
    }
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
        pageView.backgroundColor = [UIColor clearColor];
        [self.scrollView addSubview:pageView];
        [self.viewArray  addObject:pageView];
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
    [cell bindWithTitle:_titleArray[indexPath.row] showSeperator:(indexPath.row + 1 == _titleArray.count)];
    [cell setSelected:(_selectedIndex == indexPath.row)];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedIndex != indexPath.row) {
        [self scrollContentWithTitleTapped:indexPath.row];
        [self setupDelegate];
    }
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
    [self.titleLineScrollView setContentOffset:
                              CGPointMake((self.titleArray.count - 1 - _selectedIndex) * _cellWidth, 0) animated:YES];
    [self setupDelegate];
    [_titleCollectionView reloadData];
}


#pragma mark - setter/getter
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
        _scrollView.bounces                        = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                              0,
                                                              self.bounds.size.width,
                                                              kKTScrollPageTitleHight)];
        UIView *underLine = [[UIView alloc] initWithFrame:
                             CGRectMake(0, _titleView.bounds.size.height-0.5, _titleView.bounds.size.width, 0.5)];
        underLine.backgroundColor = [UIColor orangeColor];
        [_titleView addSubview:underLine];
        underLine.hidden = YES;
        
        _titleView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_titleView];
    }
    return _titleView;
}

- (UIScrollView *)titleLineScrollView {
    if (!_titleLineScrollView) {
        _titleLineScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                              _titleView.frame.size.height  - kKTScrollPageTitleHight/13,
                                                                              self.bounds.size.width,
                                                                              kKTScrollPageTitleHight/13)];
        float titleWidth = self.bounds.size.width / self.titleArray.count;
        _titleLineScrollView.contentSize = CGSizeMake(titleWidth * self.viewArray.count * 2 - 1,
                                                      0);
        UIView *titleUnderLine = [[UIView alloc] initWithFrame:CGRectMake(titleWidth * (self.viewArray.count- 1) ,
                                                                          _titleView.frame.origin.y,
                                                                          titleWidth,
                                                                          _titleLineScrollView.bounds.size.height)];
        titleUnderLine.backgroundColor                      = [UIColor orangeColor];
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
        
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                  0,
                                                                                  self.frame.size.width,
                                                                                  _titleView.frame.size.height)
                                                  collectionViewLayout:layout];

        [_titleCollectionView registerClass:[KTScrollPageTitleCell class] forCellWithReuseIdentifier:@"KTScrollPageTitleCell"];
        _cellWidth = _titleCollectionView.frame.size.width / self.titleArray.count;
        _titleCollectionView.scrollEnabled                  = NO;
        _titleCollectionView.showsHorizontalScrollIndicator = NO;
        _titleCollectionView.delegate                       = self;
        _titleCollectionView.dataSource                     = self;
        _titleCollectionView.allowsSelection = YES;
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
