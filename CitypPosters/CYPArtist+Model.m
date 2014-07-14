//
//  CYPArtist+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPArtist+Model.h"

NSString *const artistPropertyName = @"name";

@implementation CYPArtist (Model)

+ (instancetype)artistInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary {
    CYPArtist *artist = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPArtist class]) inManagedObjectContext:context];
    
    artist.name = dictionary[artistPropertyName];
    
    return artist;
}

- (void)awakeFromInsert {
    self.artistId = [[NSUUID UUID] UUIDString];
}

@end
