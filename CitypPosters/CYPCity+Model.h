//
//  CYPCity+Model.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPCity.h"

extern NSString *const cityNameKey;
extern NSString *const cityCountryKey;

@interface CYPCity (Model)

+ (instancetype)cityInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary;

@end
