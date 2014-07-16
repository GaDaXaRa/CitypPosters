//
//  CYPModelDocument.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPEvent+Model.h"

@interface CYPModelDocument : UIManagedDocument

- (void)importEvents:(NSArray *)events;
- (CYPEvent *)fetchEventById:(NSString *)eventId;

@end
