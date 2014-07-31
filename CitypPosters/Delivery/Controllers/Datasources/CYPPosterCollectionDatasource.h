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

@property (nonatomic, copy) void (^noResultsBlock)();
@property (nonatomic, copy) void (^hasResultsBlock)();

- (void)imageDidUpdated:(UIImage *)image forEventId:(NSString *)eventId;

@end
