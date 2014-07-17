//
//  CYPViewAnimationHelper.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 15/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPViewAnimationHelper.h"

@implementation CYPViewAnimationHelper

- (void)animateViewToRight:(UIView *)view inRect:(CGRect)rect completion:(void (^)())completion {
    view.frame = rect;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame = CGRectMake(0 - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)animateViewFromLeft:(UIView *)view inRect:(CGRect)rect completion:(void (^)())completion {
    view.frame = CGRectMake(0 - rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.frame =rect;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)animateViewFadeIn:(UIView *)view inRect:(CGRect)rect completion:(void(^)())completion {
    view.frame = rect;
    view.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.alpha = 0.8;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)animateViewFadeOut:(UIView *)view inRect:(CGRect)rect completion:(void(^)())completion {
    view.frame = rect;
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        completion();
    }];
}

@end
