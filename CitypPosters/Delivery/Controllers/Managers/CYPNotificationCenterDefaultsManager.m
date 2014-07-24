//
//  CYPNotificationCenterDefaultsManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPNotificationCenterDefaultsManager.h"
#import "CYPUserDefaultsManager.h"
#import "CYPVenue+Model.h"
#import "CYPEvent+Model.h"

@implementation CYPNotificationCenterDefaultsManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addGenreToUserDefaults:) name:kGenredAddedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addCityToUserDefaults:) name:kCityAddedNotification object:nil];
    }
    return self;
}

- (void)addGenreToUserDefaults:(NSNotification *)notificaton {
    CYPUserDefaultsManager *userDefaults = [[CYPUserDefaultsManager alloc] init];
    [userDefaults addGenreToDefaults:notificaton.userInfo[@"name"]];
}

- (void)addCityToUserDefaults:(NSNotification *)notificaton {
    CYPUserDefaultsManager *userDefaults = [[CYPUserDefaultsManager alloc] init];
    [userDefaults addCityToDefaults:notificaton.userInfo[@"name"]];
}

@end
