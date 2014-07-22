//
//  CYPFetchResultControllerManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPFetchResultControllerManager.h"
#import "CYPEvent+Model.h"
#import "CYPCity+Model.h"
#import "CYPGenre+Model.h"
#import "CYPUserDefaultsManager.h"

@interface CYPFetchResultControllerManager ()

@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;

@end

@implementation CYPFetchResultControllerManager

- (void)awakeFromNib {
    [self.userDefaults notifySelectedGenresWithBlock:^(NSArray *selectedGenres) {
        [self changePredicateAndFetch];
    }];
    [self.userDefaults notifySelectedCitiesWithBlock:^(NSArray *selectedCities) {
        [self changePredicateAndFetch];
    }];
    [self.userDefaults notifySelectedCalendarWithBlock:^(NSUInteger selectedCalendar) {
        [self changePredicateAndFetch];
    }];
}

- (void)changePredicateAndFetch {
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    self.fetchedResultsController.fetchRequest.predicate = [self buildPredicate];
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    [self.fetchedResultsDelegate.collectionView performBatchUpdates:^{
        [self.fetchedResultsDelegate.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
    } completion:nil];
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
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstDate" ascending:YES];
    
    NSFetchRequest *fetchRequest = [CYPEvent requestEventsWithPredicate:[self buildPredicate]];
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
    NSArray *citiesArray = self.userDefaults.selectedCities;
    
    NSPredicate *calendarPredicate = [NSPredicate predicateWithFormat:@"firstDate < %@", [self dateByIndex:self.userDefaults.selectedCalendar]];
    NSPredicate *genresPredicate = [NSPredicate predicateWithFormat:@"ANY genres.name IN %@", genresArray];
    NSPredicate *citiesPredicate = [NSPredicate predicateWithFormat:@"venue.city.name IN %@", citiesArray];
    
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[calendarPredicate, genresPredicate, citiesPredicate]];
    return predicate;
}

- (NSDate *)dateByIndex:(NSUInteger)index {
    switch (index) {
        case 1:
            return [NSDate dateWithTimeIntervalSinceNow:90*24*60*60];
            break;
        case 2:
            return [NSDate dateWithTimeIntervalSinceNow:30*24*60*60];
            break;
            
        default:
            return [NSDate dateWithTimeIntervalSinceNow:360*24*60*60];
            break;
    }
}

@end
