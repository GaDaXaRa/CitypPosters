//
//  CYPGenresFilterDatasource.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 19/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPGenresFilterDatasource.h"
#import "CYPGenre+Model.h"
#import "CYPGenresFilterTableViewCell.h"
#import "CYPUserDefaultsManager.h"

@interface CYPGenresFilterDatasource ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;
@property (copy, nonatomic) NSMutableArray *selectedArray;

@end

@implementation CYPGenresFilterDatasource

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    if (!self.model.managedObjectContext) {
        return nil;
    }
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSFetchRequest *fetchRequest = [CYPGenre requestAllGenresWithOrder:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[nameSortDescriptor];
    [NSFetchedResultsController deleteCacheWithName:@"Genres"];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.model.managedObjectContext sectionNameKeyPath:nil cacheName:@"Genres"];
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (NSMutableArray *)selectedArray {
    if(!_selectedArray) {
        _selectedArray = [NSMutableArray arrayWithArray:self.userDefaults.selectedGenres];
    }
    
    return _selectedArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController sections][section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYPGenre *genre = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CYPGenresFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"genreCell" forIndexPath:indexPath];
    cell.label.text = genre.name;
    if ([self.selectedArray containsObject:genre.name]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CYPGenre *genre = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if ([self.selectedArray containsObject:genre.name]) {
        [self.selectedArray removeObject:genre.name];
    } else {
        [self.selectedArray addObject:genre.name];
    }
    
    self.userDefaults.selectedGenres = self.selectedArray.copy;
    [tableView reloadData];
}

@end
