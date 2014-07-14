//
//  CYPEvent.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CYPArtist, CYPDates, CYPGenre, CYPVenue;

@interface CYPEvent : NSManagedObject

@property (nonatomic, retain) NSString * eventId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *dates;
@property (nonatomic, retain) NSSet *genres;
@property (nonatomic, retain) NSSet *invitedArtists;
@property (nonatomic, retain) NSSet *mainArtists;
@property (nonatomic, retain) CYPVenue *venue;
@end

@interface CYPEvent (CoreDataGeneratedAccessors)

- (void)addDatesObject:(CYPDates *)value;
- (void)removeDatesObject:(CYPDates *)value;
- (void)addDates:(NSSet *)values;
- (void)removeDates:(NSSet *)values;

- (void)addGenresObject:(CYPGenre *)value;
- (void)removeGenresObject:(CYPGenre *)value;
- (void)addGenres:(NSSet *)values;
- (void)removeGenres:(NSSet *)values;

- (void)addInvitedArtistsObject:(CYPArtist *)value;
- (void)removeInvitedArtistsObject:(CYPArtist *)value;
- (void)addInvitedArtists:(NSSet *)values;
- (void)removeInvitedArtists:(NSSet *)values;

- (void)addMainArtistsObject:(CYPArtist *)value;
- (void)removeMainArtistsObject:(CYPArtist *)value;
- (void)addMainArtists:(NSSet *)values;
- (void)removeMainArtists:(NSSet *)values;

@end
