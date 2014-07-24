//
//  CYPEventActionsManager.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 21/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPEvent+Model.h"

@interface CYPEventActionsManager : NSObject

- (void)saveEventImageToPhotoRoll:(CYPEvent *)event;
- (void)shareEvent:(CYPEvent *)event inController:(UIViewController *)controller;
- (void)saveEventToCalendar:(CYPEvent *)event;

@end
