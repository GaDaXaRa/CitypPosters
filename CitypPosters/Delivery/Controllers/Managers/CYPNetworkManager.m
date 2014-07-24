//
//  CYPNetworkManager.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPNetworkManager.h"

static NSString *const baseUrl = @"http://citypposters.apiary.io/";

@implementation CYPNetworkManager

+ (void)getAllEventsWithCompletion:(void(^)(NSArray *events))completion {
    NSString *url = [baseUrl stringByAppendingString:@"events"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *eventsUrl = [NSURL URLWithString:url];
    [[session dataTaskWithURL:eventsUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray *events = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        completion(events);
    }] resume];
}

+ (void)downloadImageWithUrl:(NSString *)url completion:(void(^)(UIImage *image))completion {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *imageUrl = [NSURL URLWithString:url];
    [[session dataTaskWithURL:imageUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion([UIImage imageWithData:data]);
    }] resume];
}

@end
