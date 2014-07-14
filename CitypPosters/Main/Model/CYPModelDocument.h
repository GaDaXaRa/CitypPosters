//
//  CYPModelDocument.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CYPModelDocument : UIManagedDocument

- (void)importDataWithEvents:(NSArray *)events error:(NSError *__autoreleasing *)error;

@end
