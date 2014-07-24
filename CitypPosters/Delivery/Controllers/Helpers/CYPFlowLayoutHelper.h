//
//  CYPFlowLayoutHelper.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPFlowLayoutHelper : NSObject

- (UICollectionViewFlowLayout *)fullScreenFlowLayoutWithItemSize:(CGSize) itemSize;
- (UICollectionViewFlowLayout *)zoomFlowLayoutWithItemSize:(CGSize) itemSize;

@end
