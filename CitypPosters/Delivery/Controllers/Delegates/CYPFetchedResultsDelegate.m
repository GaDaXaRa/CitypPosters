//
//  CYPFetchedResultsDelegate.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPFetchedResultsDelegate.h"

@interface CYPFetchedResultsDelegate ()

@property (strong, nonatomic) NSMutableArray *objectChanges;

@end

@implementation CYPFetchedResultsDelegate

- (NSMutableArray *)objectChanges {
    if (!_objectChanges) {
        _objectChanges = [[NSMutableArray alloc] init];
    }
    
    return _objectChanges;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    NSMutableDictionary *change = [NSMutableDictionary new];
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
    }
    
    [self.objectChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.objectChanges.count > 0) {
        [self.collectionView performBatchUpdates:^{
            for (NSDictionary *change in self.objectChanges) {
                [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                    NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                    switch (type) {
                        case NSFetchedResultsChangeInsert:
                            [self.collectionView insertItemsAtIndexPaths:@[obj]];
                            break;
                            
                        default:
                            break;
                    }
                }];
            }
        } completion:nil];
        
        [self.objectChanges removeAllObjects];
    }
}

@end
