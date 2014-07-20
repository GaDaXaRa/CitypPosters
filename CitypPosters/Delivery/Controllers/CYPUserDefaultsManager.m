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

@interface CYPUserDefaultsManager ()

@property (nonatomic, copy) void (^backgroundChangedBlock)(NSString *newImageName);
@property (nonatomic, copy) void (^selectedGenresChangedBlock)(NSArray *selectedGenres);

@end

@implementation CYPUserDefaultsManager

@synthesize backgroundImage = _backgroundImage;
@synthesize selectedGenres = _selectedGenres;

- (NSString *)backgroundImage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _backgroundImage = [defaults objectForKey:backgroundImageKey];
    
    return _backgroundImage;
}

- (void)setBackgroundImage:(NSString *)backgroundImage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:backgroundImage forKey:backgroundImageKey];
    
    [defaults synchronize];
}

- (NSArray *)selectedGenres {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _selectedGenres = [defaults arrayForKey:selectedGenresKey];
    
    return _selectedGenres;
}

- (void)setSelectedGenres:(NSArray *)selectedGenres {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:selectedGenres forKey:selectedGenresKey];
    
    [defaults synchronize];
}

- (void)notifyBackgroundChangesWithBlock:(void(^)(NSString *newImageName))block {
    self.backgroundChangedBlock = block;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults addObserver:self
               forKeyPath:backgroundImageKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)notifySelectedGenresWithBlock:(void(^)(NSArray *selectedGenres))block {
    self.selectedGenresChangedBlock = block;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults addObserver:self
               forKeyPath:selectedGenresKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:backgroundImageKey]) {
        self.backgroundChangedBlock(change[@"new"]);
    } else if ([keyPath isEqualToString:selectedGenresKey]) {
        self.selectedGenresChangedBlock(change[@"new"]);
    }
}

- (void)dealloc {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObserver:self forKeyPath:backgroundImageKey];
    [defaults removeObserver:self forKeyPath:selectedGenresKey];
}

@end
