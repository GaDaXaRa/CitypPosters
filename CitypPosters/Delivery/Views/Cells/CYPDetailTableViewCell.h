//
//  CYPDetailTableViewCell.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 23/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPEvent+Model.h"

@interface CYPDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lineLabel;

- (void)drawCellForSection:(NSIndexPath *)indexPath andEvent:(CYPEvent *)event;

@end
