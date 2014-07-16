//
//  CYPFetchResultControllerManager.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 16/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPModelDocument.h"
#import "CYPFetchedResultsDelegate.h"

@interface CYPFetchResultControllerManager : NSObject

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) CYPModelDocument *model;
@property (strong, nonatomic) IBOutlet CYPFetchedResultsDelegate *fetchedResultsDelegate;

@end
