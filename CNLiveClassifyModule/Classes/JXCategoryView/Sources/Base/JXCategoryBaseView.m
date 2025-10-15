//
//  JXCategoryBaseView.m
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "JXCategoryBaseView.h"
#import "JXCategoryFactory.h"
#import <CNLiveBaseKit/CNLiveBaseKit.h>

@interface JXCategoryBaseView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, JXCategoryBaseCellDelegate>

//@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) CGPoint lastContentViewContentOffset;

@end

@implementation JXCategoryBaseView

- (void)dealloc
{
    if (self.contentScrollView) {
        [self.contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (void)initializeData
{
    _dataSource = [NSMutableArray array];
    _selectedIndex = 0;
    _cellWidth = JXCategoryViewAutomaticDimension;
    _cellWidthIncrement = 0;
    _cellSpacing = 20;
    _averageCellWidthEnabled = YES;
    _cellWidthZoomEnabled = NO;
    _cellWidthZoomScale = 1.2;
    _cellWidthZoomScrollGradientEnabled = YES;
    _lastContentViewContentOffset = CGPointZero;
}

- (void)initializeViews
{
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        JXCategoryCollectionView *collectionView = [[JXCategoryCollectionView alloc] initWithFrame:CGRectMake(0, kStatusHeight, KScreenWidth-45, 50) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [collectionView registerClass:[self preferredCellClass] forCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass])];
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 10);
        collectionView;
    });
    [self addSubview:self.collectionView];
    
}

- (void)setDefaultSelectedIndex:(NSInteger)defaultSelectedIndex
{
    _defaultSelectedIndex = defaultSelectedIndex;

    self.selectedIndex = defaultSelectedIndex;
}

- (void)setContentScrollView:(UIScrollView *)contentScrollView
{
    if (_contentScrollView != nil) {
        [_contentScrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _contentScrollView = contentScrollView;

    [contentScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)reloadData {
    [self refreshDataSource];
    [self refreshState];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)reloadCell:(NSUInteger)index {
    if (index >= self.dataSource.count) {
        return;
    }
    JXCategoryBaseCellModel *cellModel = self.dataSource[index];
    [self refreshCellModel:cellModel index:index];
    JXCategoryBaseCell *cell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    [cell reloadData:cellModel];
}

- (void)selectItemAtIndex:(NSUInteger)index {
    [self selectCellAtIndex:index];
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    [self reloadData];
}

#pragma mark - Subclass Override

- (void)refreshDataSource {

}

- (void)refreshState {
    if (self.selectedIndex >= self.dataSource.count) {
        self.selectedIndex = 0;
    }
    
    CGFloat totalWidth = self.collectionView.width;//self.bounds.size.width;

    CGFloat totalItemWidth = 12;//self.cellSpacing;
//    CGFloat totalCellWidthMy = self.cellSpacing;  // My
    for (int i = 0; i < self.dataSource.count; i++) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[i];
        cellModel.index = i;
        cellModel.cellWidth = [self preferredCellWidthAtIndex:i] + self.cellWidthIncrement;
        cellModel.cellWidthZoomEnabled = self.cellWidthZoomEnabled;
        cellModel.cellWidthZoomScale = 1.0;
        cellModel.cellSpacing = self.cellSpacing;
//        totalItemWidth += cellModel.cellWidth + self.cellSpacing;   //原代码我给注释换地方了
        if (i == self.selectedIndex) {
            cellModel.selected = YES;
            cellModel.cellWidthZoomScale = self.cellWidthZoomScale;
//            totalCellWidthMy += cellModel.cellWidth + self.cellSpacing; // My
        }else {
            cellModel.selected = NO;
//            totalCellWidthMy += cellModel.cellWidth + self.cellSpacing; // My
        }
        totalItemWidth += cellModel.cellWidth;     //原代码我给注释换地方了
        [self refreshCellModel:cellModel index:i];
    }
    totalItemWidth += self.cellSpacing*(self.dataSource.count-1)+12;
    if (self.averageCellWidthEnabled && totalItemWidth < totalWidth) {//totalCellWidthMy replaced totalItemWidth
        //如果总的内容宽度都没有超过视图度，就将cellWidth等分
        //e.g  cellWidth * 1.7 + cellWidth + cellWidth + ··· = totalWidth
        CGFloat cellWidth = 0;
        if (self.dataSource.count > 0) {
//            cellWidth = (totalWidth - (self.dataSource.count + 1)*self.cellSpacing)/self.dataSource.count;
//            cellWidth = (totalWidth - (self.dataSource.count + 1)*self.cellSpacing)/(self.dataSource.count-1+self.cellWidthZoomScale);     // My
            cellWidth = (totalWidth - 12-12 - (self.dataSource.count - 1)*self.cellSpacing)/(self.dataSource.count-1+self.cellWidthZoomScale);
        }
        [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.cellWidth = cellWidth;
        }];
    }

    __block CGFloat frameXOfSelectedCell = 12;//self.cellSpacing;
    __block CGFloat selectedCellWidth = 0;
    __block CGFloat totalCellWidth = 12;//self.cellSpacing;
    [self.dataSource enumerateObjectsUsingBlock:^(JXCategoryBaseCellModel * cellModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.selectedIndex) {
            frameXOfSelectedCell += cellModel.cellWidth + self.cellSpacing;
        }else if (idx == self.selectedIndex) {
            selectedCellWidth = cellModel.cellWidth;
        }
        totalCellWidth += cellModel.cellWidth;
    }];
    totalCellWidth += self.cellSpacing*(self.dataSource.count-1) + 12;
    CGFloat minX = 0;
    CGFloat maxX = totalCellWidth - totalWidth;
    CGFloat targetX = frameXOfSelectedCell - totalWidth/2.0 + selectedCellWidth/2.0;
    [self.collectionView setContentOffset:CGPointMake(MAX(MIN(maxX, targetX), minX), 0) animated:YES];

    [self.contentScrollView setContentOffset:CGPointMake(self.selectedIndex*self.contentScrollView.bounds.size.width, 0) animated:NO];
}

- (BOOL)selectCellAtIndex:(NSInteger)targetIndex {
    if (targetIndex >= self.dataSource.count) {
        return NO;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didSelectedItemAtIndex:)]) {
        [self.delegate categoryView:self didSelectedItemAtIndex:targetIndex];
    }

    if (targetIndex == self.selectedIndex) {
        return NO;
    }

    JXCategoryBaseCellModel *lastCellModel = self.dataSource[self.selectedIndex];
    JXCategoryBaseCellModel *selectedCellModel = self.dataSource[targetIndex];
    [self refreshSelectedCellModel:selectedCellModel unselectedCellModel:lastCellModel];

    JXCategoryBaseCell *lastCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
    [lastCell reloadData:lastCellModel];

    JXCategoryBaseCell *selectedCell = (JXCategoryBaseCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    [selectedCell reloadData:selectedCellModel];

    if (self.cellWidthZoomEnabled) {
        [self.collectionView.collectionViewLayout invalidateLayout];

        //延时为了解决cellwidth变化，点击最后几个cell，scrollToItem会出现位置偏移bug
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        });
    }else {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }

    [self.contentScrollView setContentOffset:CGPointMake(targetIndex*self.contentScrollView.bounds.size.width, 0) animated:YES];

    self.selectedIndex = targetIndex;

    return YES;
}


- (void)refreshSelectedCellModel:(JXCategoryBaseCellModel *)selectedCellModel unselectedCellModel:(JXCategoryBaseCellModel *)unselectedCellModel {
    selectedCellModel.selected = YES;
    selectedCellModel.cellWidthZoomScale = self.cellWidthZoomScale;
    unselectedCellModel.selected = NO;
    unselectedCellModel.cellWidthZoomScale = 1.0;
}

- (void)contentOffsetOfContentScrollViewDidChanged:(CGPoint)contentOffset {
    CGFloat ratio = contentOffset.x/self.contentScrollView.bounds.size.width;
    if (ratio > self.dataSource.count - 1 || ratio < 0) {
        //超过了边界，不需要处理
        return;
    }
    if (contentOffset.x == 0 && self.selectedIndex == 0 && self.lastContentViewContentOffset.x == 0) {
        //滚动到了最左边，且已经选中了第一个，且之前的contentOffset.x为0
        return;
    }
    CGFloat maxContentOffsetX = self.contentScrollView.contentSize.width - self.contentScrollView.bounds.size.width;
    if (contentOffset.x == maxContentOffsetX && self.selectedIndex == self.dataSource.count - 1 && self.lastContentViewContentOffset.x == maxContentOffsetX) {
        //滚动到了最右边，且已经选中了最后一个，且之前的contentOffset.x为maxContentOffsetX
        return;
    }
    ratio = MAX(0, MIN(self.dataSource.count - 1, ratio));
    NSInteger baseIndex = floorf(ratio);
    CGFloat remainderRatio = ratio - baseIndex;

    if (remainderRatio == 0) {
        //滑动翻页，需要更新选中状态
        //滑动一小段距离，然后放开回到原位，contentOffset同样的值会回调多次。例如在index为1的情况，滑动放开回到原位，contentOffset会多次回调CGPoint(width, 0)
        if (!(self.lastContentViewContentOffset.x == contentOffset.x && self.selectedIndex == baseIndex)) {
            [self scrollselectItemAtIndex:baseIndex];
        }
    }else {
        //快速滑动翻页，当remainderRatio没有变成0，但是已经翻页了，需要通过下面的判断，触发选中
        if (fabs(ratio - self.selectedIndex) > 1) {
            NSInteger targetIndex = baseIndex;
            if (ratio < self.selectedIndex) {
                targetIndex = baseIndex + 1;
            }
//            if (self.delegateFlags.didScrollSelectedItemAtIndexFlag) {
//                [self.delegate categoryView:self didScrollSelectedItemAtIndex:targetIndex];
//            }
//            [self _selectCellAtIndex:targetIndex handleContentScrollView:NO isClicked:NO];
            [self selectCellAtIndex:targetIndex];
        }
        if (self.cellWidthZoomEnabled && self.cellWidthZoomScrollGradientEnabled) {
            JXCategoryBaseCellModel *leftCellModel = (JXCategoryBaseCellModel *)self.dataSource[baseIndex];
            JXCategoryBaseCellModel *rightCellModel = (JXCategoryBaseCellModel *)self.dataSource[baseIndex + 1];
            leftCellModel.cellWidthZoomScale = [JXCategoryFactory interpolationFrom:self.cellWidthZoomScale to:1.0 percent:remainderRatio];
            rightCellModel.cellWidthZoomScale = [JXCategoryFactory interpolationFrom:1.0 to:self.cellWidthZoomScale percent:remainderRatio];
            [self.collectionView.collectionViewLayout invalidateLayout];
        }
    }
}

- (CGFloat)preferredCellWidthAtIndex:(NSInteger)index {
    return 0;
}

- (Class)preferredCellClass {
    return JXCategoryBaseCell.class;
}

- (void)refreshCellModel:(JXCategoryBaseCellModel *)cellModel index:(NSInteger)index {

}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self preferredCellClass]) forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    JXCategoryBaseCell *categoryCell = (JXCategoryBaseCell *)cell;
    categoryCell.categoryBaseCellDelegate = self;
    [categoryCell reloadData:self.dataSource[indexPath.item]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self clickselectItemAtIndex:indexPath.row];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==0) {
        return UIEdgeInsetsMake(0, 12, 0, self.cellSpacing);
    } else if (section==self.dataSource.count-1) {
        return UIEdgeInsetsMake(0, self.cellSpacing, 0, 12);
    } else {
        return UIEdgeInsetsMake(0, self.cellSpacing, 0, self.cellSpacing);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JXCategoryBaseCellModel *cellModel = self.dataSource[indexPath.item];
    return CGSizeMake(cellModel.cellWidth, self.collectionView.bounds.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.cellSpacing;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if ((self.contentScrollView.isTracking || self.contentScrollView.isDecelerating)) {
            //用户滚动引起的contentOffset变化，才处理。
            [self contentOffsetOfContentScrollViewDidChanged:contentOffset];
        }
        self.lastContentViewContentOffset = contentOffset;
    }
}

#pragma mark - Other

- (CGRect)getTargetCellFrame:(NSInteger)targetIndex
{
    CGFloat x = 12;//self.cellSpacing;
    for (int i = 0; i < targetIndex; i ++) {
        JXCategoryBaseCellModel *cellModel = self.dataSource[i];
        x += cellModel.cellWidth + self.cellSpacing;
    }
    CGFloat width = self.dataSource[targetIndex].cellWidth;
    return CGRectMake(x, 0, width, self.collectionView.bounds.size.height);
}

#pragma mark - Private

- (void)clickselectItemAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didClickSelectedItemAtIndex:)]) {
        [self.delegate categoryView:self didClickSelectedItemAtIndex:index];
    }

    [self selectCellAtIndex:index];
}

- (void)scrollselectItemAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryView:didScrollSelectedItemAtIndex:)]) {
        [self.delegate categoryView:self didScrollSelectedItemAtIndex:index];
    }

    [self selectCellAtIndex:index];
}

- (void)refreshTitleViewUIWithIndex:(NSInteger)index {
    
}

@end
