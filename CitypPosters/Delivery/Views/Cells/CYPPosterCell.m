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
    self.posterImageWiew.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.posterImageWiew.layer.shadowOffset = CGSizeMake(1.5, 1.5);
    self.posterImageWiew.layer.shadowRadius = 3.0f;
    self.posterImageWiew.layer.shadowOpacity = 1.0f;
    [self.contentView addSubview:self.posterImageWiew];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.posterImageWiew.frame = CGRectInset(self.bounds, 10, 10);
    
}

@end
