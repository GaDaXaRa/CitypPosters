//
//  CYPArtist+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPArtist+Model.h"

@implementation CYPArtist (Model)

- (void)awakeFromInsert {
    self.artistId = [[NSUUID UUID] UUIDString];
}

@end
