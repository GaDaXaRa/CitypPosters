//
//  UIView+LineSeparator.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LineSeparator)

- (void)addBotomSeparatorWithColor:(UIColor *)color height:(CGFloat)height heightOffset:(CGFloat)heightOffset edgeInset:(UIEdgeInsets)edgeInset;

- (void)addTopSeparatorWithColor:(UIColor *)color height:(CGFloat)height heightOffset:(CGFloat)heightOffset edgeInset:(UIEdgeInsets)edgeInset;

@end
