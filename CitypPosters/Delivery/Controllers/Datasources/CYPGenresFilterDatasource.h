//
//  CYPGenresFilterDatasource.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 19/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CYPModelDocument.h"

@interface CYPGenresFilterDatasource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) CYPModelDocument *model;

@end
