//
//  CYPDetailViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 15/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPDetailViewController.h"
#import "CYPVenue+Model.h"
#import "CYPCity+Model.h"
#import "CYPGenre.h"
#import "CYPDates.h"
#import "CYPEventActionsManager.h"
#import "CYPMapViewController.h"
#import "UIView+LineSeparator.h"

@interface CYPDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) IBOutlet CYPEventActionsManager *actionsManager;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation CYPDetailViewController

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        NSString *format = [NSDateFormatter dateFormatFromTemplate:@"dd MMMM / HH,mm" options:0 locale:[NSLocale currentLocale]];
        [_dateFormatter setDateFormat:format];
    }
    
    return _dateFormatter;
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
    NSUInteger section = indexPath.section;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    [self initialFontSettingsForCell:cell];
    switch (section) {
        case 0: {
            cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:21];
            cell.textLabel.text = self.event.name;
            break;
        }
        case 1: {
            cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:22];
            cell.textLabel.text = [[self.event.mainArtists allObjects][indexPath.row] name];;
            break;
        }
        case 2: {
            cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
            NSDate *date = [[self.event.dates allObjects][indexPath.row] date];
            cell.textLabel.text = [self.dateFormatter stringFromDate:date];
            break;
        }
        case 3: {
            cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
            if (indexPath.row == 0) {
                cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", self.event.venue.name, self.event.venue.city.name];
            } else if (indexPath.row == 1) {
                cell.textLabel.text = self.event.venue.address;
            };
            break;
        }
        case 5:
            if (indexPath.row == 0) {
                cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:14];
                cell.textLabel.text = @"Géneros:";
            } else {
                cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
                cell.textLabel.text = [[self.event.genres allObjects][indexPath.row - 1] name];
            };
            break;
            
        case 4:
            if ([self.event.invitedArtists count]) {
                if (indexPath.row == 0) {
                    cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:14];
                    cell.textLabel.text = @"Artistas invitados:";
                } else {
                    cell.textLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
                    cell.textLabel.text = [[self.event.invitedArtists allObjects][indexPath.row - 1] name];
                }
                
                break;
            }
    }
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
            return [self.event.dates count];
        case 3:
            return self.event.venue.address ? 2 : 1;
        case 4:
            return 1 + [self.event.invitedArtists count];
        case 5:
            return 1 + [self.event.genres count];
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

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor blackColor];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1) {
        return 18;
    }
    return 26;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 2:
            return 20;
            break;
        case 4:
            return self.event.invitedArtists.count ? 15 : 0;
        case 5:
            return self.event.genres.count ? 15 : 0;
        default:
            break;
    }
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *sectionsWithSeparator = @[@2,@3,@4];
    if ([sectionsWithSeparator containsObject:[NSNumber numberWithInt:section]]) {
        UIView *separator = [[UIView alloc] initWithFrame:[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]].frame];
        NSUInteger height = [self tableView:tableView heightForHeaderInSection:section] / 2;
        [separator addBotomSeparatorWithColor:[UIColor whiteColor] height:1 heightOffset:height edgeInset:UIEdgeInsetsZero];
        return separator;
    }
    
    return [UIView new];
}

- (IBAction)tapOnTableView:(UITapGestureRecognizer *)sender {
    [self.delegate detailViewControllerFished:self];
}

@end
