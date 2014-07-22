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
NSString *const eventIdKey = @"eventId";
NSString *const kGenredAddedNotification = @"EventAddedToConextNtofication";

@implementation CYPEvent (Model)

+ (instancetype)eventInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary {
    CYPEvent *event = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPEvent class]) inManagedObjectContext:context];
    
    event.mainArtists = [event importArtists:dictionary[mainArtistsKey] inContext:context];
    event.invitedArtists = [event importArtists:dictionary[invitedArtistsKey] inContext:context];
    event.venue = [event importVenue:dictionary[venueKey] inContext:context];
    event.genres = [event importGenres:dictionary[genresKey] inContext:context];
    event.dates = [event importDates:dictionary[eventDatesKey] inContext:context];
    event.firstDate = [self retrieveFirstDate:event.dates];
    event.name = dictionary[eventNameKey];
    event.eventId = dictionary[eventIdKey];
    
    return event;
}

+ (NSDate *)retrieveFirstDate:(NSSet *)dates {
    NSArray *array = [dates allObjects];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    array = [array sortedArrayUsingDescriptors:@[sortDescriptor]];
    return [[array firstObject] date];
}

+ (NSFetchRequest *)requestAllEventsWithOrder:(NSString *)orderKey ascending:(BOOL)ascending {
    NSFetchRequest *fetchRequest = [CYPEvent entityRequestWithBatchSize:20];
    
    [fetchRequest setSortDescriptors:[CYPEvent sortDescriptorsWithOrder:orderKey ascending:ascending]];
    
    return fetchRequest;
}

+ (NSFetchRequest *)requestEventsWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [CYPEvent entityRequestWithBatchSize:20];
    fetchRequest.predicate = predicate;
    
    [fetchRequest setSortDescriptors:[CYPEvent sortDescriptorsWithOrder:@"name" ascending:YES]];
    
    return fetchRequest;
}

+ (NSFetchRequest *)requestEventsWithSortDescriptors:(NSArray *)sortDescriptors {
    NSFetchRequest *fetchRequest = [CYPEvent entityRequestWithBatchSize:20];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    return fetchRequest;
}

+ (NSFetchRequest *)entityRequestWithBatchSize:(NSUInteger)batchSize {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([CYPEvent class])];
    [fetchRequest setFetchBatchSize:batchSize];
    
    return fetchRequest;
}

+ (NSArray *)sortDescriptorsWithOrder:(NSString *)orderKey ascending:(BOOL)ascending {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:orderKey ascending:ascending];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    return sortDescriptors;
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
    for (NSString *genreName in genres) {
        CYPGenre *genre = [CYPGenre fetchGenreByName:genreName inContext:context];
        if (!genre) {
            genre = [CYPGenre genreInContext:context withName:genreName];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGenredAddedNotification object:nil userInfo:@{@"name":genreName}];
        }
        
        if (genre) {
            [auxSet addObject:genre];
        }
    }
    return auxSet.copy;
}

- (NSSet *)importDates:(NSArray *)dates inContext:(NSManagedObjectContext *)context {
    NSMutableSet *auxSet = [[NSMutableSet alloc] initWithCapacity:dates.count];
    
    for (NSString *dateString in dates) {
        CYPDates *date = [CYPDates dateInContext:context withString:dateString];
        if (date) {
            [auxSet addObject: date];
        }
    }
    
    return auxSet.copy;
}

- (CYPVenue *)importVenue:(NSDictionary *)venueDictionary inContext:(NSManagedObjectContext *)context{
    return [CYPVenue venueInContext:self.managedObjectContext withDictionary:venueDictionary];
}

@end
