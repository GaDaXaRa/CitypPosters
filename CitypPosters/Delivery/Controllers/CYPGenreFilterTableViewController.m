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
#import "CYPGenre+Model.h"
#import "CYPGenresFilterDatasource.h"

@interface CYPGenreFilterTableViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) IBOutlet CYPGenresFilterDatasource *datasource;

@end

@implementation CYPGenreFilterTableViewController

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
    self.datasource.model = self.model;
    self.tableView.alwaysBounceVertical = NO;
}

@end
