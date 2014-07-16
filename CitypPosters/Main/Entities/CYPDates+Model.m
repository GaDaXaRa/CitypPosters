//
//  CYPDates+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPDates+Model.h"

NSString *const dateDateKey = @"date";

@implementation CYPDates (Model)

+ (instancetype)dateInContext:(NSManagedObjectContext *)context withDate:(NSDate *)newDate {
    CYPDates *date = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPDates class]) inManagedObjectContext:context];
    
    date.date = newDate;
    
    return date;
}

+ (instancetype)dateInContext:(NSManagedObjectContext *)context withString:(NSString *)newDate {
    CYPDates *date = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPDates class]) inManagedObjectContext:context];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy HH:mm"];
    date.date = [df dateFromString: newDate];
    
    return date;
}

@end
