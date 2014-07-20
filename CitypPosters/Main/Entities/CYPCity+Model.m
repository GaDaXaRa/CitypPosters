//
//  CYPCity+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPCity+Model.h"

NSString *const cityNameKey = @"name";
NSString *const cityCountryKey = @"country";

@implementation CYPCity (Model)

+ (instancetype)cityInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary {
    CYPCity *city = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPCity class]) inManagedObjectContext:context];
    
    city.name = dictionary[cityNameKey];
    city.country = dictionary[cityCountryKey];
    
    return city;
}

+ (NSFetchRequest *)requestAllCitiesWithOrder:(NSString *)orderKey ascending:(BOOL)ascending {
    NSFetchRequest *fetchRequest = [CYPCity entityRequestWithBatchSize:20];
    
    [fetchRequest setSortDescriptors:[CYPCity sortDescriptorsWithOrder:orderKey ascending:ascending]];
    
    return fetchRequest;
}

+ (CYPCity *)fetchCityByName:(NSString *)name inContext:(NSManagedObjectContext *)context {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSFetchRequest *request = [CYPCity requestCitiesWithPredicate:predicate];
    
    return [[context executeFetchRequest:request error:nil] firstObject];
}

+ (NSFetchRequest *)requestCitiesWithPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [CYPCity entityRequestWithBatchSize:20];
    fetchRequest.predicate = predicate;
    
    [fetchRequest setSortDescriptors:[CYPCity sortDescriptorsWithOrder:@"name" ascending:YES]];
    
    return fetchRequest;
}

+ (NSArray *)fetchAllCityNamesInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [CYPCity requestAllCitiesWithOrder:@"name" ascending:YES];
    NSArray *citiesArray = [context executeFetchRequest:request error:NULL];
    NSMutableArray *aux = [[NSMutableArray alloc] initWithCapacity:citiesArray.count];
    for (CYPCity *city in citiesArray) {
        [aux addObject:city.name];
    }
    
    return aux.copy;
}

+ (NSFetchRequest *)entityRequestWithBatchSize:(NSUInteger)batchSize {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([CYPCity class])];
    [fetchRequest setFetchBatchSize:batchSize];
    
    return fetchRequest;
}

+ (NSArray *)sortDescriptorsWithOrder:(NSString *)orderKey ascending:(BOOL)ascending {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:orderKey ascending:ascending];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    return sortDescriptors;
}

@end
