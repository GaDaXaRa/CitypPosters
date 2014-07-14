//
//  CYPPosterCell.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPPosterCell.h"

@interface CYPPosterCell ()

@end

@implementation CYPPosterCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, (2 * self.bounds.size.height) / 3, self.bounds.size.height);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
