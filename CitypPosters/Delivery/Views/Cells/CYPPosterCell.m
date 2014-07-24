//
//  CYPPosterCell.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPPosterCell.h"

@implementation CYPPosterCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    
    return self;
}

- (void)setUp {
    self.posterImageWiew = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.posterImageWiew.contentMode = UIViewContentModeScaleAspectFit;
    self.posterImageWiew.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    self.posterImageWiew.layer.shadowOffset = CGSizeMake(3, 3);
    self.posterImageWiew.layer.shadowOpacity = 0.7f;
    [self.contentView addSubview:self.posterImageWiew];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.posterImageWiew.frame = CGRectInset(self.bounds, 20, 10);
}

@end
