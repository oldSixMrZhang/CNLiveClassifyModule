//
//  JXCategoryBaseCell.h
//  UI系列测试
//
//  Created by jiaxin on 2018/3/15.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXCategoryBaseCellModel.h"

@protocol JXCategoryBaseCellDelegate <NSObject>

- (void)refreshTitleViewUIWithIndex:(NSInteger)index;

@end

@interface JXCategoryBaseCell : UICollectionViewCell

@property (nonatomic, strong) JXCategoryBaseCellModel *cellModel;

- (void)initializeViews NS_REQUIRES_SUPER;

- (void)reloadData:(JXCategoryBaseCellModel *)cellModel NS_REQUIRES_SUPER;

@property (nonatomic, weak) id <JXCategoryBaseCellDelegate> categoryBaseCellDelegate;

@end
