//
//  CYPDetailViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 15/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPDetailViewController.h"
#import "CYPGenre.h"
#import "CYPDates.h"
#import "CYPVenue.h"
#import "CYPEventActionsManager.h"
#import "CYPMapViewController.h"
#import "UIView+LineSeparator.h"
#import "CYPDetailTableViewCell.h"

@interface CYPDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet CYPEventActionsManager *actionsManager;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (nonatomic, strong) CYPDetailTableViewCell *prototypeCell;

@end

@implementation CYPDetailViewController

- (CYPDetailTableViewCell *)prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    }
    return _prototypeCell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.tableView.alwaysBounceVertical = NO;
}

- (void) viewDidLayoutSubviews {
    [self.toolBar addTopSeparatorWithColor:[UIColor whiteColor] height:1 heightOffset:5 edgeInset:UIEdgeInsetsZero];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate detailViewControllerFished:self];
}

- (void)initialFontSettingsForCell:(UITableViewCell *)cell {
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Regular" size:14];
    cell.textLabel.text = @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CYPDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    [cell drawCellForSection:indexPath andEvent:self.event];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return [self.event.mainArtists count];
            break;
        case 2:
            return [self.event.dates count] + 1;
        case 3:
            return self.event.venue.address ? 2 : 1;
        case 4:
            return [self.event.invitedArtists count] ? 2 + [self.event.invitedArtists count] : 0;
        case 5:
            return 2 + [self.event.genres count];
        default:
            return 0;
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"venueMap"]) {
        CYPMapViewController *mapController = segue.destinationViewController;
        mapController.event = self.event;
    }
}

- (IBAction)exitFromMap:(UIStoryboardSegue *)segue {
    
}

- (IBAction)calendarPressed:(id)sender {
    [self.actionsManager saveEventToCalendar:self.event];
}

- (IBAction)downloadPressed:(id)sender {
    [self.actionsManager saveEventImageToPhotoRoll:self.event];
}

- (IBAction)sharePressed:(id)sender {
    [self.actionsManager shareEvent:self.event inController:self];
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.delegate detailViewControllerNextDetail:self];
    } else {
        [self.delegate detailViewControllerPreviousDetail:self];
    }
}

- (IBAction)tapOnTableView:(UITapGestureRecognizer *)sender {
    [self.delegate detailViewControllerFished:self];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor blackColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.prototypeCell drawCellForSection:indexPath andEvent:self.event];
    [self.prototypeCell layoutIfNeeded];
    
    return self.prototypeCell.bounds.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

@end
