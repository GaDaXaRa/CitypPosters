//
//  CYPCoordinatorViewController.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYPModelDocument.h"

@interface CYPCoordinatorViewController : UIViewController

@property (strong, nonatomic) CYPModelDocument *model;

- (void)hideSettings;

@end
