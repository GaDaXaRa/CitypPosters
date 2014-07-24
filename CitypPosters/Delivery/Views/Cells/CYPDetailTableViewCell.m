//
//  CYPDetailTableViewCell.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 23/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPDetailTableViewCell.h"
#import "CYPVenue.h"
#import "CYPCity.h"
#import "UIView+LineSeparator.h"

@interface CYPDetailTableViewCell ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparator;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelToSeparatorConstrain;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalSpaceConstrain;

@end

@implementation CYPDetailTableViewCell

- (void)initialFontSettings {
    self.lineLabel.textColor = [UIColor whiteColor];
    self.lineLabel.adjustsFontSizeToFitWidth = YES;
    self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Regular" size:14];
    self.lineLabel.text = @"";
}

- (void)drawCellForSection:(NSIndexPath *)indexPath andEvent:(CYPEvent *)event {
    [self initialFontSettings];
    self.labelToSeparatorConstrain.constant = 1;
    self.verticalSpaceConstrain.constant = 1;
    self.bottomSeparator.backgroundColor = [UIColor clearColor];
    switch (indexPath.section) {
        case 0: {
            self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:21];
            self.lineLabel.text = event.name;
            self.bottomSeparator.backgroundColor = [UIColor whiteColor];
        }
            break;
        case 1: {
            self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:22];
            self.lineLabel.text = [[event.mainArtists allObjects][indexPath.row] name];
            
        }
            break;
        case 2: {
            if (indexPath.row < event.dates.count) {
                self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
                NSDate *date = [[event.dates allObjects][indexPath.row] date];
                self.lineLabel.text = [self.dateFormatter stringFromDate:date];
            } else {
                [self labelAsSeparator];
            }
        }break;
        case 3: {
            
            self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
            if (indexPath.row == 0) {
                self.lineLabel.text = [NSString stringWithFormat:@"%@, %@", event.venue.name, event.venue.city.name];
                
            } else if (indexPath.row == 1) {
                if (event.venue.address) {
                    self.lineLabel.text = event.venue.address;
                } else {
                    [self labelAsSeparator];
                    self.bottomSeparator.backgroundColor = [UIColor whiteColor];
                }
            } else {
                [self labelAsSeparator];
                self.bottomSeparator.backgroundColor = [UIColor whiteColor];
            };
            break;
        }
        case 5:
            if (indexPath.row == 0) {
                self.lineLabel.text = @"-";
                self.lineLabel.textColor = [UIColor clearColor];
            } else if (indexPath.row == 1) {
                self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Italic" size:14];
                self.lineLabel.text = @"Géneros:";
            } else {
                self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-LightItalic" size:14];
                self.lineLabel.text = [[event.genres allObjects][indexPath.row - 2] name];
            };
            break;
            
        case 4:
            if ([event.invitedArtists count]) {
                if (indexPath.row == 0) {
                    self.lineLabel.text = @"-";
                    self.lineLabel.textColor = [UIColor clearColor];
                } else if (indexPath.row == 1) {
                    self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:14];
                    self.lineLabel.text = @"Artistas invitados:";
                } else {
                    self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:14];
                    self.lineLabel.text = [[event.invitedArtists allObjects][indexPath.row - 2] name];
                }
                
                
            }
            break;
    }
    CGSize size = [self sizeByIndexPath:indexPath andEvent:event];
    self.bounds = CGRectMake(0, 0, size.width, size.height);
    
}

- (void)labelAsSeparator {
    self.lineLabel.font = [UIFont fontWithName:@"Superclarendon-Regular" size:10];
    self.lineLabel.text = @"-";
    self.lineLabel.textColor = [UIColor clearColor];
}

- (CGSize)sizeByIndexPath:(NSIndexPath *)indexPath andEvent:(CYPEvent *)event {
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    if (indexPath.section == 0) {
        return CGSizeMake(size.width, size.height + 20);
    }
    
    return size;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        NSString *format = [NSDateFormatter dateFormatFromTemplate:@"dd MMMM / HH,mm" options:0 locale:[NSLocale currentLocale]];
        [_dateFormatter setDateFormat:format];
    }
    
    return _dateFormatter;
}

@end
