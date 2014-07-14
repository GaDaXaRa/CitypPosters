//
//  CYPEvent+Model.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPEvent+Model.h"

@implementation CYPEvent (Model)

- (void)awakeFromInsert {
    self.eventId = [[NSUUID UUID] UUIDString];
}

@end
