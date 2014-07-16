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
    self.posterImageWiew.clipsToBounds = YES;
    self.posterImageWiew.image = [UIImage imageNamed:@"misfits_poster_b-n_web1.jpg"];
    self.posterImageWiew.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.posterImageWiew];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.posterImageWiew.frame = CGRectInset(self.bounds, 30, 30);
}

@end
