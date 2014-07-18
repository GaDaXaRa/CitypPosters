//
//  CYPGenresFilterTableViewCell.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 18/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPGenresFilterTableViewCell.h"

@interface CYPGenresFilterTableViewCell ()

@end

@implementation CYPGenresFilterTableViewCell

- (IBAction)switched:(id)sender {
    self.switchChangedBlock(self);
}


@end
