//
//  CYPCalendarHelper.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 21/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPCalendarHelper.h"
#import <EventKit/EventKit.h>

static NSString *const calendarKey = @"CYPCalendar";

@interface CYPCalendarHelper ()

@property (strong, nonatomic) EKEventStore *eventStore;

@end

@implementation CYPCalendarHelper

- (EKEventStore *)eventStore {
    if (!_eventStore) {
        _eventStore = [[EKEventStore alloc] init];
    }
    
    return _eventStore;
}

- (void)requestAccessWithCompletion:(void(^)(BOOL granted, NSError *error))completion {
    [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:completion];
}

- (BOOL)addEventAt:(NSDate *)eventDate withTitle:(NSString *)title inLocation:(NSString *)location {
    EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
    
    EKCalendar *calendar = nil;
    NSString *calendarIdentifier = [[NSUserDefaults standardUserDefaults] valueForKey:calendarKey];
    
    if (calendarIdentifier) {
        calendar = [self.eventStore calendarWithIdentifier:calendarIdentifier];
    }
    
    if (!calendar) {
        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:self.eventStore];
        [calendar setTitle:@"Citypposters"];
        
        for (EKSource *s in self.eventStore.sources) {
            if (s.sourceType == EKSourceTypeLocal) {
                calendar.source = s;
                break;
            }
        }
        
         NSString *calendarIdentifier = [calendar calendarIdentifier];
        
        NSError *error = nil;
        BOOL saved = [self.eventStore saveCalendar:calendar commit:YES error:&error];
        if (saved) {
            [[NSUserDefaults standardUserDefaults] setObject:calendarIdentifier forKey:calendarKey];
        } else {
            return NO;
        }
    }
    
    if (!calendar) {
        return NO;
    }
    
    event.calendar = calendar;
    event.location = location;
    event.title = title;
    
    NSDate *startDate = eventDate;
    event.startDate = startDate;
    event.endDate = [startDate dateByAddingTimeInterval:3600 * 2];
    
    NSError *error = nil;
    BOOL result = [self.eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&error];
    if (result) {
        return YES;
    } else {
        return NO;
    }
}

@end
