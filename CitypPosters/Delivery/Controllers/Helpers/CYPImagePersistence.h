//
//  CYPImagePersistence.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPImagePersistence : NSObject

+ (void)persistImage:(UIImage *)image withFilename:(NSString *)fileName;

+ (UIImage *)imageWithFileName:(NSString *)fileName;

+ (BOOL)existsImage:(NSString *)fileName;

@end
