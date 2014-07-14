//
//  CYPCity+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPCity+Model.h"

NSString *const cityNameKey = @"name";
NSString *const cityCountryKey = @"country";

@implementation CYPCity (Model)

+ (instancetype)cityInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary {
    CYPCity *city = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPCity class]) inManagedObjectContext:context];
    
    city.name = dictionary[cityNameKey];
    city.country = dictionary[cityCountryKey];
    
    return city;
}

@end
