//
//  CYPEvent+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPEvent+Model.h"
#import "CYPArtist+Model.h"
#import "CYPVenue+Model.h"
#import "CYPDates+Model.h"
#import "CYPGenre+Model.h"

NSString *const eventNameKey = @"eventName";
NSString *const eventPosterUrlKey = @"eventPoster";
NSString *const eventDatesKey = @"dates";
NSString *const genresKey = @"genres";
NSString *const mainArtistsKey = @"mainArtists";
NSString *const invitedArtistsKey = @"invitedArtists";
NSString *const venueKey = @"venue";

@implementation CYPEvent (Model)

+ (instancetype)eventInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary {
    CYPEvent *event = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPEvent class]) inManagedObjectContext:context];
    
    event.mainArtists = [event importArtists:dictionary[mainArtistsKey] inContext:context];
    event.invitedArtists = [event importArtists:dictionary[invitedArtistsKey] inContext:context];
    event.venue = [event importVenue:dictionary[venueKey] inContext:context];
    event.genres = [event importGenres:dictionary[genresKey] inContext:context];
    event.dates = [event importDates:dictionary[eventDatesKey] inContext:context];
    event.name = dictionary[eventNameKey];
    
    return event;
}

- (void)awakeFromInsert {
    self.eventId = [[NSUUID UUID] UUIDString];
}

- (NSSet *)importArtists:(NSArray *)artists inContext:(NSManagedObjectContext *)context {
    NSMutableSet *artistsArray = [[NSMutableSet alloc] initWithCapacity:artists.count
                                    ];
    for (NSDictionary *artistDictionary in artists) {
        [artistsArray addObject:[CYPArtist artistInContext:context withDictionary:artistDictionary]];
    }
    
    return artistsArray.copy;
}

- (NSSet *)importGenres:(NSArray *)genres inContext:(NSManagedObjectContext *)context {
    NSMutableSet *auxSet = [[NSMutableSet alloc] initWithCapacity:genres.count];
    
    for (NSString *genre in genres) {
        [auxSet addObject:[CYPGenre genreInContext:context withName:genre]];
    }
    
    return auxSet.copy;
}

- (NSSet *)importDates:(NSArray *)dates inContext:(NSManagedObjectContext *)context {
    NSMutableSet *auxSet = [[NSMutableSet alloc] initWithCapacity:dates.count];
    
    for (NSDate *date in dates) {
        [auxSet addObject:[CYPDates dateInContext:context withDate:date]];
    }
    
    return auxSet.copy;
}

- (CYPVenue *)importVenue:(NSDictionary *)venueDictionary inContext:(NSManagedObjectContext *)context{
    return [CYPVenue venueInContext:self.managedObjectContext withDictionary:venueDictionary];
}

@end
