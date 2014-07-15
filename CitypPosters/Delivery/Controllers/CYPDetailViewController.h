//
//  CYPDetailViewController.h
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 15/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CYPDetailViewController;
@protocol CYPDetailViewControllerDelegate <NSObject>

- (void)detailViewControllerFished:(CYPDetailViewController *)controller;

@end

@interface CYPDetailViewController : UIViewController

@property (weak, nonatomic) id<CYPDetailViewControllerDelegate> delegate;

@end
