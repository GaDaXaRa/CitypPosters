//
//  CYPCalendarHelper.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 21/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPCalendarHelper : NSObject

- (void)requestAccessWithCompletion:(void(^)(BOOL granted, NSError *error))completion;
- (BOOL)addEventAt:(NSDate *)date withTitle:(NSString *)title inLocation:(NSString *)location;

@end
