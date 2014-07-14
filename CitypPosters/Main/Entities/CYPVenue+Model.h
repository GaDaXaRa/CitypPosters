//
//  CYPVenue+Model.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPVenue.h"

extern NSString *const venueNameKey;
extern NSString *const venueLatitudeKey;
extern NSString *const venueLongitudeKey;
extern NSString *const venueAddressKey;
extern NSString *const venueZipKey;
extern NSString *const venueCityKey;

@interface CYPVenue (Model)

+ (instancetype)venueInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary;

@end
