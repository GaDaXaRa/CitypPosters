//
//  CYPFlowLayoutHelper.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPFlowLayoutHelper.h"

@interface CYPFlowLayoutHelper ()

@property (strong, nonatomic) UICollectionViewFlowLayout *fullScreenlayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *zoomLayout;

@end

@implementation CYPFlowLayoutHelper

- (UICollectionViewFlowLayout *)fullScreenlayout {
    if (!_fullScreenlayout) {
        _fullScreenlayout = [self layoutWithInitialValues:_fullScreenlayout];
    }
    
    return _fullScreenlayout;
}

- (UICollectionViewFlowLayout *)zoomLayout {
    if (!_zoomLayout) {
        _zoomLayout = [self layoutWithInitialValues:_zoomLayout];
    }
    
    return _zoomLayout;
}

- (UICollectionViewFlowLayout *)fullScreenFlowLayoutWithItemSize:(CGSize) itemSize {
    self.fullScreenlayout.itemSize = itemSize;
    return self.fullScreenlayout;
}

- (UICollectionViewFlowLayout *)zoomFlowLayoutWithItemSize:(CGSize)itemSize {
    self.zoomLayout.itemSize = CGSizeMake(itemSize.width / 2, itemSize.height / 2);
    return self.zoomLayout;
}

- (UICollectionViewFlowLayout *)layoutWithInitialValues:(UICollectionViewFlowLayout *)layout {
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return layout;
}

@end
