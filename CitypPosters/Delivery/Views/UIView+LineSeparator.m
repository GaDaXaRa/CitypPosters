//
//  UIView+LineSeparator.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "UIView+LineSeparator.h"

@implementation UIView (LineSeparator)

- (void)addBotomSeparatorWithColor:(UIColor *)color height:(CGFloat)height heightOffset:(CGFloat)heightOffset edgeInset:(UIEdgeInsets)edgeInset {
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(edgeInset.left, self.bounds.size.height, self.frame.size.width - edgeInset.left - edgeInset.right, height)];
    [separatorView setBackgroundColor:color];
    [self addSubview:separatorView];
}

- (void)addTopSeparatorWithColor:(UIColor *)color height:(CGFloat)height heightOffset:(CGFloat)heightOffset edgeInset:(UIEdgeInsets)edgeInset {
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(edgeInset.left, -height - heightOffset, self.frame.size.width - edgeInset.left - edgeInset.right, height)];
    [separatorView setBackgroundColor:color];
    [self addSubview:separatorView];
}

@end
