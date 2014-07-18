//
//  CYPAsideTableViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPAsideTableViewController.h"
#import "CYPCoordinatorViewController.h"
#import "CYPImageTiler.h"
#import "CYPUserDefaultsManager.h"
#import "CYPGenreFilterTableViewController.h"

@interface CYPAsideTableViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;

@end

@implementation CYPAsideTableViewController

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
    CYPCoordinatorViewController *parentViewController = (CYPCoordinatorViewController *)[[self parentViewController] parentViewController];
    [self.swipeRight addTarget:parentViewController action:@selector(hideSettings)];
    self.imageView.image = [CYPImageTiler imgeTiledWithName:self.userDefaults.backgroundImage];
    [self.userDefaults notifyBackgroundChangesWithBlock:^(NSString *newImageName) {
        self.imageView.image = [CYPImageTiler imgeTiledWithName:self.userDefaults.backgroundImage];
    }];
    
    self.tableView.backgroundView = self.imageView;
    self.tableView.backgroundView.alpha = 0.6;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"genresSegue"]) {
        CYPGenreFilterTableViewController *nextVC = segue.destinationViewController;
        nextVC.model = self.model;
    }
}

@end
