//
//  CYPModelDocument.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPModelDocument.h"
#import "CYPEvent+Model.h"

@implementation CYPModelDocument

- (void)importDataWithEvents:(NSArray *)events error:(NSError *__autoreleasing *)error {
    [self importEvents:events];
    [self.managedObjectContext save:error];
}

- (void)importEvents:(NSArray *)events {
    for (NSDictionary *eventDictionary in events) {
        [CYPEvent eventInContext:self.managedObjectContext withDictionary:eventDictionary];
    }
}

@end
