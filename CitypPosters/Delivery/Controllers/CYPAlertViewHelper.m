//
//  CYPAlertViewHelper.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 21/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPAlertViewHelper.h"

@implementation CYPAlertViewHelper

+ (void)showSimpleAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    dispatch_async(MAIN_QUEUE, ^{
        [alert show];
    });    
}

@end