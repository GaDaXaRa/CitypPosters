//
//  CYPArtist.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CYPEvent;

@interface CYPArtist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * artistId;
@property (nonatomic, retain) NSSet *events;
@property (nonatomic, retain) NSSet *invitedToEvents;
@end

@interface CYPArtist (CoreDataGeneratedAccessors)

- (void)addEventsObject:(CYPEvent *)value;
- (void)removeEventsObject:(CYPEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

- (void)addInvitedToEventsObject:(CYPEvent *)value;
- (void)removeInvitedToEventsObject:(CYPEvent *)value;
- (void)addInvitedToEvents:(NSSet *)values;
- (void)removeInvitedToEvents:(NSSet *)values;

@end
