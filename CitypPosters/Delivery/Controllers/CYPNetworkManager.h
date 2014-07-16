//
//  CYPNetworkManager.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPNetworkManager : NSObject

+ (void)getAllEventsWithCompletion:(void(^)(NSArray *events))completion;

+ (void)downloadImageWithUrl:(NSString *)url completion:(void(^)(UIImage *image))completion;

@end