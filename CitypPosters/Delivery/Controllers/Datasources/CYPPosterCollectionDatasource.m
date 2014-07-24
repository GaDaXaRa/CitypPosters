//
//  CYPPosterCollectionDatasource.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPPosterCollectionDatasource.h"
#import "CYPPosterCell.h"
#import "CYPImagePersistence.h"
#import "CYPEvent+Model.h"

static NSString *const cellID = @"posterCell";
static NSString *const defaultImageName = @"default_poster";

@implementation CYPPosterCollectionDatasource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger results = [[[self.fetchedResultController sections] firstObject] numberOfObjects];
    if(results) {
        if (self.hasResultsBlock) {
            self.hasResultsBlock();
        }
    } else {
        if (self.noResultsBlock) {
            self.noResultsBlock();
        }
    }
    return [[[self.fetchedResultController sections] firstObject] numberOfObjects];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultController sections] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYPEvent *event = [self.fetchedResultController objectAtIndexPath:indexPath];
    CYPPosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.posterImageWiew.image = [self imageForEventId:event.eventId];
    return cell;
}

- (UIImage *)imageForEventId:(NSString *)eventId {
    UIImage *image = [CYPImagePersistence imageWithFileName:eventId];
    if (!image) {
        image = [UIImage imageNamed:defaultImageName];
    }
    
    return image;
}

@end
