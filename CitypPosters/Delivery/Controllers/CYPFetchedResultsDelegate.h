//
//  CYPFetchedResultsDelegate.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPFetchedResultsDelegate : NSObject<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@end
