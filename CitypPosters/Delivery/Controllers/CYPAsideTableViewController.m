//
//  CYPAsideTableViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPAsideTableViewController.h"
#import "CYPCoordinatorViewController.h"
#import "CYPUserDefaultsManager.h"
#import "CYPGenreFilterTableViewController.h"

@interface CYPAsideTableViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CYPAsideTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    CYPCoordinatorViewController *parentViewController = (CYPCoordinatorViewController *)[[self parentViewController] parentViewController];
    [self.swipeRight addTarget:parentViewController action:@selector(hideSettings)];
    
    self.tableView.tableFooterView = [UIView new];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"genresSegue"]) {
        CYPGenreFilterTableViewController *nextVC = segue.destinationViewController;
        nextVC.model = self.model;
    }
}

@end
