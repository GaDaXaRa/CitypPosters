//
//  CYPDates+Model.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPDates.h"

extern NSString *const dateDateKey;

@interface CYPDates (Model)

+ (instancetype)dateInContext:(NSManagedObjectContext *)context withDate:(NSDate *)date;

+ (instancetype)dateInContext:(NSManagedObjectContext *)context withString:(NSString *)date;

@end
