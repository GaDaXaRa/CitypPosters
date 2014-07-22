//
//  CYPImagePersistence.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPImagePersistence.h"
#import "CYPImageTiler.h"

@implementation CYPImagePersistence

+ (void)persistImage:(UIImage *)image withFilename:(NSString *)fileName {
    UIImage *newImage;
    newImage = [CYPImageTiler minimizeImage:image];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", fileName]];
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
}

+ (BOOL)existsImage:(NSString *)fileName {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", fileName]];
    
    return [fileManager fileExistsAtPath:fullPath];
}

+ (UIImage *)imageWithFileName:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", fileName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

@end
