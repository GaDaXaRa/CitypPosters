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

@interface CYPPosterCollectionDatasource ()

@end

@implementation CYPPosterCollectionDatasource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[[self.fetchedResultController sections] firstObject] numberOfObjects];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultController sections] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYPEvent *event = [self.fetchedResultController objectAtIndexPath:indexPath];
    CYPPosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.posterImageWiew.image = [CYPImagePersistence imageWithFileName:event.eventId];
    return cell;
}

@end
