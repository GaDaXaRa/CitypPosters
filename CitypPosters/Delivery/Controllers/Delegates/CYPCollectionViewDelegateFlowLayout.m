//
//  CYPCollectionViewDelegateFlowLayout.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPCollectionViewDelegateFlowLayout.h"

@implementation CYPCollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

@end
