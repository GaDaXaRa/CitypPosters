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

+ (NSFetchRequest *)requestAllGenresWithOrder:(NSString *)orderKey ascending:(BOOL)ascending {
    NSFetchRequest *fetchRequest = [CYPGenre entityRequestWithBatchSize:20];
    
    [fetchRequest setSortDescriptors:[CYPGenre sortDescriptorsWithOrder:orderKey ascending:ascending]];
    
    return fetchRequest;
}


+ (NSFetchRequest *)entityRequestWithBatchSize:(NSUInteger)batchSize {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([CYPGenre class])];
    [fetchRequest setFetchBatchSize:batchSize];
    
    return fetchRequest;
}

+ (NSArray *)sortDescriptorsWithOrder:(NSString *)orderKey ascending:(BOOL)ascending {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:orderKey ascending:ascending];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    return sortDescriptors;
}

+ (CYPGenre *)fetchGenreByName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSFetchRequest *request = [CYPGenre requestGenresWithPredicate:predicate];
    
    return [[context executeFetchRequest:request error:nil] firstObject];
}

+ (NSFetchRequest *)requestGenresWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [CYPGenre entityRequestWithBatchSize:20];
    fetchRequest.predicate = predicate;
    
    [fetchRequest setSortDescriptors:[CYPGenre sortDescriptorsWithOrder:@"name" ascending:YES]];
    
    return fetchRequest;
}

@end
