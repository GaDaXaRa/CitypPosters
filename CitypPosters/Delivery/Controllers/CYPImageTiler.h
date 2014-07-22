//
//  CYPImageTiler.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYPImageTiler : NSObject

+ (UIImage *)imgeTiledWithName:(NSString *)imageName;
+ (UIImage *)minimizeImage:(UIImage *)image;

@end
