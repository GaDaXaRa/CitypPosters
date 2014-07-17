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

@interface CYPAsideTableViewController ()
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRight;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

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
    self.imageView.image = [CYPImageTiler imgeTiledWithName:@"fondo1"];
    self.tableView.backgroundView = self.imageView;
}

@end
