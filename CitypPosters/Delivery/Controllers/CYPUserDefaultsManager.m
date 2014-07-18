//
//  CYPUserDefaultsManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPUserDefaultsManager.h"

static NSString *const backgroundImageKey = @"CYPBackgroundImage";

@interface CYPUserDefaultsManager ()

@property (nonatomic, copy) void (^backgroundChangedBlock)(NSString *newImageName);

@end

@implementation CYPUserDefaultsManager

@synthesize backgroundImage = _backgroundImage;

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

- (void)notifyBackgroundChangesWithBlock:(void(^)(NSString *newImageName))block {
    self.backgroundChangedBlock = block;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults addObserver:self
               forKeyPath:backgroundImageKey
                  options:NSKeyValueObservingOptionNew
                  context:NULL];
}

- (void)dealloc {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObserver:self forKeyPath:backgroundImageKey];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:backgroundImageKey]) {
        self.backgroundChangedBlock(change[@"new"]);
    }
}

@end
