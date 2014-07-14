//
//  CYPVenue.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CYPCity, CYPEvent;

@interface CYPVenue : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * zip;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * venueId;
@property (nonatomic, retain) NSSet *events;
@property (nonatomic, retain) CYPCity *city;
@end

@interface CYPVenue (CoreDataGeneratedAccessors)

- (void)addEventsObject:(CYPEvent *)value;
- (void)removeEventsObject:(CYPEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
