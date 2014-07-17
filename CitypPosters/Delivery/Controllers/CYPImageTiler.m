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

@end
