//
//  CYPPosterCollectionDatasource.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPPosterCollectionDatasource : NSObject<UICollectionViewDataSource>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultController;

@end
