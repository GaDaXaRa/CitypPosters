//
//  CYPVenue+Annotation.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPVenue+Annotation.h"
#import "CYPCity+Model.h"

@implementation CYPVenue (Annotation)

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    NSString *venueAddress = self.address;
    if (!venueAddress) {
        venueAddress = @"";
    }
    
    if (self.zip) {
        venueAddress = [venueAddress stringByAppendingString:[NSString stringWithFormat:@", %@", self.zip]];
    }
    
    return [venueAddress stringByAppendingString:[NSString stringWithFormat:@", %@, %@", self.city.name, self.city.country]];
}

@end
