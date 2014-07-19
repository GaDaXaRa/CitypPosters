//
//  CYPCoordinatorViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 17/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPCoordinatorViewController.h"
#import "CYPMainScreenViewController.h"
#import "CYPAsideTableViewController.h"

@interface CYPCoordinatorViewController ()

@property (weak, nonatomic) IBOutlet UIView *asideView;
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic)BOOL aside;

@end

@implementation CYPCoordinatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.asideView.frame = CGRectMake(self.view.frame.size.width, self.asideView.frame.size.height, self.asideView.frame.size.width, self.asideView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"mainEmbedSegue"]) {
        CYPMainScreenViewController *nextVC = (CYPMainScreenViewController *)[segue.destinationViewController topViewController];
        nextVC.model = self.model;
    } else if ([segue.identifier isEqualToString:@"settingsSegue"]) {
        CYPAsideTableViewController *nextVC = (CYPAsideTableViewController *)[segue.destinationViewController topViewController];
        nextVC.model = self.model;
    }
}

- (void)hideSettings {    
    [UIView animateWithDuration:0.5 animations:^{
        CGRect newRect = CGRectMake(0, self.mainView.frame.origin.y, self.mainView.bounds.size.width, self.mainView.bounds.size.height);
        self.mainView.frame = newRect;
        self.aside = NO;
    } completion:^(BOOL finished) {
        self.mainView.layer.shadowColor = nil;
        self.mainView.layer.shadowOffset = CGSizeZero;
        self.mainView.layer.shadowRadius = 0;
        self.mainView.layer.shadowOpacity = 0;
    }];
}

- (void)showSettings {
    if (!self.aside) {
        self.mainView.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.mainView.layer.shadowOffset = CGSizeMake(1.0, 1.0);
        self.mainView.layer.shadowRadius = 10.0f;
        self.mainView.layer.shadowOpacity = 1.0f;
        CGRect newRect = CGRectMake(-self.asideView.frame.size.width, self.mainView.frame.origin.y, self.mainView.bounds.size.width, self.mainView.bounds.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            self.mainView.frame = newRect;
            self.aside = YES;
        }];
    } else {
        [self hideSettings];
    }
}

@end
