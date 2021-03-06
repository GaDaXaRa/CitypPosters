//
//  CYPVenue+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPVenue+Model.h"
#import "CYPCity+Model.h"

NSString *const venueNameKey = @"name";
NSString *const venueLatitudeKey = @"lat";
NSString *const venueLongitudeKey = @"lon";
NSString *const venueAddressKey = @"address";
NSString *const venueZipKey = @"ZIP";
NSString *const venueCityKey = @"city";
NSString *const kCityAddedNotification = @"kCityAddedToContextNotification";

@implementation CYPVenue (Model)

+ (instancetype)venueInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary {
    CYPCity *city = [CYPCity fetchCityByName:dictionary[venueCityKey][cityNameKey] inContext:context];
    if (!city) {
        city = [CYPCity cityInContext:context withDictionary:dictionary[venueCityKey]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kCityAddedNotification object:nil userInfo:@{@"name":city.name}];
    }
    
    if (!city) {
        return nil;
    }
    
    CYPVenue *venue = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPVenue class]) inManagedObjectContext:context];
    venue.city = city;
    venue.name = dictionary[venueNameKey];
    venue.latitude = dictionary[venueLatitudeKey];
    venue.longitude = dictionary[venueLongitudeKey];
    venue.address = dictionary[venueAddressKey];
    venue.zip = dictionary[venueZipKey];
    
    return venue;
}

- (void)awakeFromInsert {
    self.venueId = [[NSUUID UUID] UUIDString];
}

@end
