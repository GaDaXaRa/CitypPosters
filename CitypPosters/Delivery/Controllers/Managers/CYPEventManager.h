//
//  CYPEventManager.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPEventManager : NSObject

@property (nonatomic, copy) void (^imageDidPersistBlock)(NSString *eventId, UIImage *image);

- (void) getAllEventsWithCompletion:(void(^)(NSArray *events))completion;

@end
