//
//  CYPModelDocument.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPModelDocument.h"
#import "CYPNetworkManager.h"

@implementation CYPModelDocument

- (void)importDataWithEvents:(NSArray *)events error:(NSError *__autoreleasing *)error {
    [self importEvents:events];    
}

- (void)importEvents:(NSArray *)events {
    [self.managedObjectContext.undoManager beginUndoGrouping];
    for (NSDictionary *eventDictionary in events) {
        if (![self fetchEventById:eventDictionary[eventIdKey]]) {
            [CYPEvent eventInContext:self.managedObjectContext withDictionary:eventDictionary];
        }
    }
    [self.managedObjectContext.undoManager endUndoGrouping];
}

- (NSArray *)filterEventsWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *request = [CYPEvent requestEventsWithPredicate:predicate];
    return [self.managedObjectContext executeFetchRequest:request error:NULL];
}

- (void)handleError:(NSError *)error userInteractionPermitted:(BOOL)userInteractionPermitted
{
    NSLog(@"💀UIManagedDocument error: %@", error.localizedDescription);
    NSArray* errors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
    if(errors != nil && errors.count > 0) {
        for (NSError *error in errors) {
            NSLog(@"  Error: %@", error.userInfo);
        }
    } else {
        NSLog(@"  %@", error.userInfo);
    }
}

- (CYPEvent *)fetchEventById:(NSString *)eventId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"eventId = %@", eventId];
    NSFetchRequest *request = [CYPEvent requestEventsWithPredicate:predicate];
    
    return [[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (CYPEvent *)fetchEventByName:(NSString *)name {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSFetchRequest *request = [CYPEvent requestEventsWithPredicate:predicate];
    
    return [[self.managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

@end
