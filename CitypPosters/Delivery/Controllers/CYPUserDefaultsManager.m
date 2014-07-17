//
//  CYPUserDefaultsManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPUserDefaultsManager.h"

@implementation CYPUserDefaultsManager

@synthesize backgroundImage = _backgroundImage;

- (NSString *)backgroundImage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _backgroundImage = [defaults objectForKey:@"CYPBackgroundImage"];
    
    return _backgroundImage;
}

- (void)setBackgroundImage:(NSString *)backgroundImage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:backgroundImage forKey:@"CYPBackgroundImage"];
    [defaults synchronize];
}

@end
