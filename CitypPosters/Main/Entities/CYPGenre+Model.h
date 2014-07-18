//
//  CYPGenre+Model.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPGenre.h"

extern NSString *const genreNameKey;

@interface CYPGenre (Model)

+ (instancetype)genreInContext:(NSManagedObjectContext *)context withName:(NSString *)name;
+ (NSFetchRequest *)requestAllGenresWithOrder:(NSString *)orderKey ascending:(BOOL)ascending;
+ (CYPGenre *)fetchGenreByName:(NSString *)name inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestGenresWithPredicate:(NSPredicate *)predicate;

@end
