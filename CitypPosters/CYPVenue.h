//
//  CYPVenue.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CYPEvent;

@interface CYPVenue : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * zip;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSSet *events;
@end

@interface CYPVenue (CoreDataGeneratedAccessors)

- (void)addEventsObject:(CYPEvent *)value;
- (void)removeEventsObject:(CYPEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
