//
//  CYPFetchResultControllerManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPFetchResultControllerManager.h"
#import "CYPEvent+Model.h"

@implementation CYPFetchResultControllerManager

- (NSFetchedResultsController *)fetchedResultsController {
    if (!self.model) {
        return nil;
    }
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    if (!self.model.managedObjectContext) {
        return nil;
    }
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSFetchRequest *fetchRequest = [CYPEvent requestAllEventsWithOrder:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[nameSortDescriptor];
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.model.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    self.fetchedResultsController.delegate = self.fetchedResultsDelegate;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

@end
