//
//  CYPUserDefaultsManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPUserDefaultsManager.h"

static NSString *const backgroundImageKey = @"CYPBackgroundImage";
static NSString *const selectedGenresKey = @"CYPSelectedGenres";
static NSString *const selectedCitiesKey = @"CYPSelectedCities";
static NSString *const selectedCalendarKey = @"CYPSelectedCalendar";

@interface CYPUserDefaultsManager ()

@property (nonatomic, copy) void (^backgroundChangedBlock)(NSString *newImageName);
@property (nonatomic, copy) void (^selectedGenresChangedBlock)(NSArray *selectedGenres);
@property (nonatomic, copy) void (^selectedCititesChangedBlock)(NSArray *selectedCities);
@property (nonatomic, copy) void (^selectedCalendarChangedBlock)(NSUInteger selectedCalendar);

@property (nonatomic, copy) NSMutableArray *observingKeys;
@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation CYPUserDefaultsManager

@synthesize backgroundImage = _backgroundImage;
@synthesize selectedGenres = _selectedGenres;
@synthesize selectedCities = _selectedCities;
@synthesize selectedCalendar = _selectedCalendar;

- (NSUserDefaults *)defaults {
    if (!_defaults) {
        _defaults = [NSUserDefaults standardUserDefaults];
    }
    
    return _defaults;
}

- (NSString *)backgroundImage {
    _backgroundImage = [self.defaults objectForKey:backgroundImageKey];
    
    return _backgroundImage;
}

- (void)setBackgroundImage:(NSString *)backgroundImage {
    [self.defaults setObject:backgroundImage forKey:backgroundImageKey];
}

- (NSArray *)selectedGenres {
    _selectedGenres = [self.defaults arrayForKey:selectedGenresKey];
    
    if (!_selectedGenres) {
        return @[];
    }
    
    return _selectedGenres;
}

- (void)setSelectedGenres:(NSArray *)selectedGenres {
    [self.defaults setObject:selectedGenres forKey:selectedGenresKey];
}

- (NSArray *)selectedCities {
    _selectedCities = [self.defaults arrayForKey:selectedCitiesKey];
    
    if (!_selectedCities) {
        return @[];
    }
    
    return _selectedCities;
}

- (void)setSelectedCities:(NSArray *)selectedCities {
    [self.defaults setObject:selectedCities forKey:selectedCitiesKey];
}

- (NSUInteger)selectedCalendar {
    _selectedCalendar = [self.defaults integerForKey:selectedCalendarKey];
    if (!_selectedCalendar) {
        return 0;
    }
    
    return _selectedCalendar;
}

- (void)setSelectedCalendar:(NSUInteger)selectedCalendar {
    [self.defaults setInteger:selectedCalendar forKey:selectedCalendarKey];
}

- (void)notifyBackgroundChangesWithBlock:(void(^)(NSString *newImageName))block {
    self.backgroundChangedBlock = block;
    [self.defaults addObserver:self
               forKeyPath:backgroundImageKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)notifySelectedGenresWithBlock:(void(^)(NSArray *selectedGenres))block {
    self.selectedGenresChangedBlock = block;
    [self.defaults addObserver:self
               forKeyPath:selectedGenresKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)notifySelectedCitiesWithBlock:(void (^)(NSArray *))block {
    self.selectedCititesChangedBlock = block;
    [self.defaults addObserver:self
               forKeyPath:selectedCitiesKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)notifySelectedCalendarWithBlock:(void(^)(NSUInteger selectedCalendar))block {
    self.selectedCalendarChangedBlock = block;
    [self.defaults addObserver:self
               forKeyPath:selectedCalendarKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)addGenreToDefaults:(NSString *)genreName {
    NSMutableArray *aux = [NSMutableArray arrayWithArray:self.selectedGenres];
    [aux addObject:genreName];
    self.selectedGenres = aux.copy;
}

- (void)addCityToDefaults:(NSString *)cityName {
    NSMutableArray *aux = [NSMutableArray arrayWithArray:self.selectedCities];
    [aux addObject:cityName];
    self.selectedCities = aux.copy;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:backgroundImageKey]) {
        self.backgroundChangedBlock(change[@"new"]);
        [self.observingKeys addObject:backgroundImageKey];
    } else if ([keyPath isEqualToString:selectedGenresKey]) {
        self.selectedGenresChangedBlock(change[@"new"]);
        [self.observingKeys addObject:selectedGenresKey];
    } else if ([keyPath isEqualToString:selectedCitiesKey]) {
        self.selectedCititesChangedBlock(change[@"new"]);
        [self.observingKeys addObject:selectedCitiesKey];
    } else if ([keyPath isEqualToString:selectedCalendarKey]) {
        self.selectedCalendarChangedBlock([change[@"new"] integerValue]);
        [self.observingKeys addObject:selectedCalendarKey];
    }
}

- (void)dealloc {
    for (NSString *key in self.observingKeys) {
        [self.defaults removeObserver:self forKeyPath:key];
    }
}

- (NSMutableArray *)observingKeys {
    if (!_observingKeys) {
        _observingKeys = [NSMutableArray array];
    }
    
    return _observingKeys;
}

@end
