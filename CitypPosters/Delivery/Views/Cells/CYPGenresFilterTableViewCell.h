//
//  CYPGenresFilterTableViewCell.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 18/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYPGenresFilterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISwitch *genreSwitch;

@property (nonatomic, copy) void (^switchChangedBlock)(CYPGenresFilterTableViewCell *cell);

@end
