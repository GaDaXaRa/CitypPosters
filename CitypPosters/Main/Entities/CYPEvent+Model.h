//
//  CYPEvent+Model.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPEvent.h"

extern NSString *const eventNameKey;
extern NSString *const eventPosterUrlKey;
extern NSString *const eventDatesKey;
extern NSString *const genresKey;
extern NSString *const mainArtistsKey;
extern NSString *const invitedArtistsKey;
extern NSString *const venueKey;
extern NSString *const eventIdKey;

@interface CYPEvent (Model)

+ (instancetype)eventInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary;

+ (NSFetchRequest *)requestAllEventsWithOrder:(NSString *)orderKey ascending:(BOOL)ascending;
+ (NSFetchRequest *)requestEventsWithPredicate:(NSPredicate *)predicate;
+ (NSFetchRequest *)requestEventsWithSortDescriptors:(NSArray *)sortDescriptors;

@end
