//
//  CYPGenre.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class CYPEvent;

@interface CYPGenre : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *events;
@end

@interface CYPGenre (CoreDataGeneratedAccessors)

- (void)addEventsObject:(CYPEvent *)value;
- (void)removeEventsObject:(CYPEvent *)value;
- (void)addEvents:(NSSet *)values;
- (void)removeEvents:(NSSet *)values;

@end
