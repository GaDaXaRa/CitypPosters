//
//  CYPImagePersistence.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPImagePersistence.h"

@implementation CYPImagePersistence

+ (void)persistImage:(UIImage *)image withFilename:(NSString *)filename {
    CGSize newSize = CGSizeMake(image.size.width / 2, image.size.height / 2);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(newImage);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", filename]];
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
}

+ (UIImage *)imageWithFileName:(NSString *)filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", filename]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

@end
