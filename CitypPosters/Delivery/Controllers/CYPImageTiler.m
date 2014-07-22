//
//  CYPImageTiler.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPImageTiler.h"

@implementation CYPImageTiler

+ (UIImage *)imgeTiledWithName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:UIEdgeInsetsZero
                                                resizingMode:UIImageResizingModeTile];
}

+ (UIImage *)minimizeImage:(UIImage *)image {
    CGSize newSize = CGSizeMake(image.size.width / 2, image.size.height / 2);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
