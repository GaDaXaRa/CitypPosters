//
//  CYPViewAnimationHelper.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 15/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPViewAnimationHelper : NSObject

- (void)animateViewToRight:(UIView *)view inRect:(CGRect)rect completion:(void (^)())completion;
- (void)animateViewFromLeft:(UIView *)view inRect:(CGRect)rect completion:(void (^)())completion;

@end
