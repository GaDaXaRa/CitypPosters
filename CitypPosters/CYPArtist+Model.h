//
//  CYPArtist+Model.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPArtist.h"

extern NSString *const artistPropertyName;

@interface CYPArtist (Model)

+ (instancetype)artistInContext:(NSManagedObjectContext *)context withDictionary:(NSDictionary *)dictionary;

@end
