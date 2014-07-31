//
//  CYPEventManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPEventManager.h"
#import "CYPNetworkManager.h"
#import "CYPImagePersistence.h"


@implementation CYPEventManager

- (void) getAllEventsWithCompletion:(void(^)(NSArray *events))completion {
    [CYPNetworkManager getAllEventsWithCompletion:^(NSArray *events) {
        for (NSDictionary *eventDictionary in events) {
            NSString *eventId = eventDictionary[@"eventId"];
            NSString *posterUrl = eventDictionary[@"eventPoster"];
            if ([CYPImagePersistence existsImage:eventId]) {
                [self callBackIfNeededWithEventId:eventId image:[CYPImagePersistence imageWithFileName:eventId]];
            } else {
                [CYPNetworkManager downloadImageWithUrl:posterUrl completion:^(UIImage *image) {
                    [CYPImagePersistence persistImage:image withFilename:eventId];
                    [self callBackIfNeededWithEventId:eventId image:image];
                }];
            }
        }
        completion(events);
    }];
}

- (void)callBackIfNeededWithEventId:(NSString *)eventId image:(UIImage *)image{
    if (self.imageDidPersistBlock) {
        self.imageDidPersistBlock(eventId, image);
    }
}

@end
