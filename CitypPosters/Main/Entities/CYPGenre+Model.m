//
//  CYPGenre+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPGenre+Model.h"

NSString *const genreNameKey = @"name";

@implementation CYPGenre (Model)

+ (instancetype)genreInContext:(NSManagedObjectContext *)context withName:(NSString *)name {
    CYPGenre *genre = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPGenre class]) inManagedObjectContext:context];
    
    genre.name = name;
    
    return genre;
}

@end
