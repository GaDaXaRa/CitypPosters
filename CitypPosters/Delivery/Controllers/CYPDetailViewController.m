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

@interface CYPDetailViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation CYPDetailViewController

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [_dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    return _dateFormatter;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)closePressed:(id)sender {
    [self.delegate detailViewControllerFished:self];
    NSLog(@"Close");
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate detailViewControllerFished:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initialFontSettingsForCell:(UITableViewCell *)cell {
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = indexPath.section;
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    [self initialFontSettingsForCell:cell];
    switch (section) {
        case 0: {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
            cell.textLabel.text = self.event.name;
            break;
        }
        case 1: {
            cell.textLabel.font = [UIFont boldSystemFontOfSize:24];
            cell.textLabel.text = [[self.event.mainArtists allObjects][indexPath.row] name];;
            break;
        }
        case 2: {
            NSDate *date = [[self.event.dates allObjects][indexPath.row] date];
            cell.textLabel.text = [self.dateFormatter stringFromDate:date];
            break;
        }
        case 3:
            if (indexPath.row == 0) {
                cell.textLabel.text = [NSString stringWithFormat:@"%@, %@", self.event.venue.name, self.event.venue.city.name];
            } else if (indexPath.row == 1) {
                cell.textLabel.text = self.event.venue.address;
            };
            break;
        case 4:
            if (indexPath.row == 0) {
                cell.textLabel.text = @"Géneros:";
            } else {
                cell.textLabel.text = [[self.event.genres allObjects][indexPath.row - 1] name];
            };
            break;
        case 5:
            if ([self.event.invitedArtists count]) {
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"Artistas invitados:";
                } else {
                    cell.textLabel.text = [[self.event.invitedArtists allObjects][indexPath.row - 1] name];
                }
            }
            break;
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
            return 2;
        case 4:
            return 1 + [self.event.genres count];
        case 5:
            return 1 + [self.event.invitedArtists count];
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 1){
        return 16;
    }
    return 26;
}
- (IBAction)tapOnTableView:(UITapGestureRecognizer *)sender {
    [self.delegate detailViewControllerFished:self];
}

@end
