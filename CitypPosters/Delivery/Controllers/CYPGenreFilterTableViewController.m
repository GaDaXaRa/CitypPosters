//
//  CYPGenreFilterTableViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 18/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPGenreFilterTableViewController.h"
#import "CYPGenresFilterTableViewCell.h"
#import "CYPUserDefaultsManager.h"
#import "CYPImageTiler.h"
#import "CYPGenre+Model.h"

@interface CYPGenreFilterTableViewController ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation CYPGenreFilterTableViewController

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
    self.fetchedResultsController.delegate = self;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundImageView.image = [CYPImageTiler imgeTiledWithName:self.userDefaults.backgroundImage];
    [self.userDefaults notifyBackgroundChangesWithBlock:^(NSString *newImageName) {
        self.backgroundImageView.image = [CYPImageTiler imgeTiledWithName:self.userDefaults.backgroundImage];
    }];
    
    self.tableView.backgroundView = self.backgroundImageView;
    self.tableView.backgroundView.alpha = 0.6;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    return cell;
}

@end
