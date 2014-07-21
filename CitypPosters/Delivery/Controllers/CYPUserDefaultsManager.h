//
//  CYPUserDefaultsManager.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPUserDefaultsManager : NSObject

@property (strong, nonatomic) NSString *backgroundImage;
@property (strong, nonatomic) NSArray *selectedGenres;
@property (strong, nonatomic) NSArray *selectedCities;
@property (nonatomic) NSUInteger selectedCalendar;

- (void)notifyBackgroundChangesWithBlock:(void(^)(NSString *newImageName))block;
- (void)notifySelectedGenresWithBlock:(void(^)(NSArray *selectedGenres))block;
- (void)notifySelectedCitiesWithBlock:(void(^)(NSArray *selectedCities))block;
- (void)notifySelectedCalendarWithBlock:(void(^)(NSUInteger selectedCalendar))block;

@end
