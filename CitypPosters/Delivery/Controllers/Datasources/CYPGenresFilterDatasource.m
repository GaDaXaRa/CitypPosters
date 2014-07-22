//
//  CYPGenresFilterDatasource.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 19/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPGenresFilterDatasource.h"
#import "CYPGenre+Model.h"
#import "CYPCity+Model.h"
#import "CYPGenresFilterTableViewCell.h"
#import "CYPUserDefaultsManager.h"

@interface CYPGenresFilterDatasource ()

@property (strong, nonatomic) NSFetchedResultsController *genresFetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *citiesFetchedResultsController;
@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;
@property (copy, nonatomic) NSMutableArray *selectedGenresArray;
@property (copy, nonatomic) NSMutableArray *selectedCitiesArray;

@end

@implementation CYPGenresFilterDatasource

- (NSFetchedResultsController *)genresFetchedResultsController {
    if (_genresFetchedResultsController != nil) {
        return _genresFetchedResultsController;
    }
    
    if (!self.model.managedObjectContext) {
        return nil;
    }
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSFetchRequest *fetchRequest = [CYPGenre requestAllGenresWithOrder:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[nameSortDescriptor];
    [NSFetchedResultsController deleteCacheWithName:@"Genres"];
    _genresFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.model.managedObjectContext sectionNameKeyPath:nil cacheName:@"Genres"];
    
	NSError *error = nil;
	if (![self.genresFetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _genresFetchedResultsController;
}

- (NSFetchedResultsController *)citiesFetchedResultsController {
    if (_citiesFetchedResultsController != nil) {
        return _citiesFetchedResultsController;
    }
    
    if (!self.model.managedObjectContext) {
        return nil;
    }
    
    NSSortDescriptor *nameSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    NSFetchRequest *fetchRequest = [CYPCity requestAllCitiesWithOrder:@"name" ascending:YES];
    fetchRequest.sortDescriptors = @[nameSortDescriptor];
    [NSFetchedResultsController deleteCacheWithName:@"Cities"];
    _citiesFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.model.managedObjectContext sectionNameKeyPath:nil cacheName:@"Cities"];
    
	NSError *error = nil;
	if (![self.citiesFetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _citiesFetchedResultsController;
}

- (NSMutableArray *)selectedGenresArray {
    if(!_selectedGenresArray) {
        _selectedGenresArray = [NSMutableArray arrayWithArray:self.userDefaults.selectedGenres];
    }
    
    return _selectedGenresArray;
}

- (NSMutableArray *)selectedCitiesArray {
    if(!_selectedCitiesArray) {
        _selectedCitiesArray = [NSMutableArray arrayWithArray:self.userDefaults.selectedCities];
    }
    
    return _selectedCitiesArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [[self.genresFetchedResultsController fetchedObjects] count];
    } else if (section == 1) {
        return [[self.citiesFetchedResultsController fetchedObjects] count];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYPGenresFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"genreCell" forIndexPath:indexPath];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    if (indexPath.section == 0) {
        CYPGenre *genre = [self.genresFetchedResultsController objectAtIndexPath:newIndexPath];
        cell.label.text = genre.name;
        if ([self.selectedGenresArray containsObject:genre.name]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    } else if (indexPath.section == 1) {
        CYPCity *city = [self.citiesFetchedResultsController objectAtIndexPath:newIndexPath];
        cell.label.text = city.name;
        if ([self.selectedCitiesArray containsObject:city.name]) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Estilos";
            break;
        case 1:
            return @"Ciudades";
            break;
        default:
            return @"";
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    view.backgroundColor = [UIColor darkGrayColor];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"AppleSDGothicNeo-SemiBold" size:16];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    [view addSubview:label];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    if (indexPath.section == 0) {
        CYPGenre *genre = [self.genresFetchedResultsController objectAtIndexPath:newIndexPath];
        if ([self.selectedGenresArray containsObject:genre.name]) {
            [self.selectedGenresArray removeObject:genre.name];
        } else {
            [self.selectedGenresArray addObject:genre.name];
        }
        self.userDefaults.selectedGenres = self.selectedGenresArray.copy;
    } else if(indexPath.section == 1) {
        CYPCity *city = [self.citiesFetchedResultsController objectAtIndexPath:newIndexPath];
        if ([self.selectedCitiesArray containsObject:city.name]) {
            [self.selectedCitiesArray removeObject:city.name];
        } else {
            [self.selectedCitiesArray addObject:city.name];
        }
        self.userDefaults.selectedCities = self.selectedCitiesArray.copy;
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:NO];
}

@end
