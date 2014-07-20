//
//  CYPFetchResultControllerManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPFetchResultControllerManager.h"
#import "CYPEvent+Model.h"
#import "CYPUserDefaultsManager.h"

@interface CYPFetchResultControllerManager ()

@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;

@end

@implementation CYPFetchResultControllerManager

- (void)awakeFromNib {
    [self.userDefaults notifySelectedGenresWithBlock:^(NSArray *selectedGenres) {
        [self changePredicateAndFetch];
    }];
}

- (void)changePredicateAndFetch {
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    self.fetchedResultsController.fetchRequest.predicate = [self buildPredicate];
    [self.fetchedResultsController performFetch:NULL];
    [self.fetchedResultsDelegate.collectionView reloadData];
}

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
    
    NSPredicate *predicate = [self buildPredicate];
    
    NSFetchRequest *fetchRequest = [CYPEvent requestEventsWithPredicate:predicate];
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

- (NSPredicate *)buildPredicate {
    NSArray *genresArray = self.userDefaults.selectedGenres;
    return [NSPredicate predicateWithFormat:@"ANY genres.name IN %@", genresArray];
}

@end
