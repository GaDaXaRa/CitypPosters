//
//  CYPSettingsViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 18/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPSettingsViewController.h"
#import "CYPImageTiler.h"
#import "CYPUserDefaultsManager.h"

@interface CYPSettingsViewController ()

@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;

@property (weak, nonatomic) IBOutlet UIImageView *background1;
@property (weak, nonatomic) IBOutlet UIImageView *background2;
@property (weak, nonatomic) IBOutlet UIImageView *background3;
@property (weak, nonatomic) IBOutlet UIImageView *background4;

@property (strong, nonatomic) NSArray *imagesArray;

@end

@implementation CYPSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.userDefaults notifyBackgroundChangesWithBlock:^(NSString *newImageName) {
        [self prepareImages];
    }];
    
    [self prepareImages];
}

- (void)prepareImages {
    self.imagesArray = @[self.background1, self.background2, self.background3, self.background4];
    for (UIImageView *imageView in self.imagesArray) {
        [self prepareImage:imageView atIndex:[self.imagesArray indexOfObject:imageView]];
    }
}

- (void)prepareImage:(UIImageView *)imageView atIndex:(NSUInteger)index {
    NSString *imageName = [NSString stringWithFormat: @"fondo%u", index + 1];
    UIImage *image = [UIImage imageNamed:imageName];
    imageView.image = image;
    imageView.layer.cornerRadius = imageView.bounds.size.width / 2;
    imageView.clipsToBounds = YES;
    imageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    UITapGestureRecognizer *imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImage:)];
    [imageView addGestureRecognizer:imageTapGesture];
    
    if ([imageName isEqualToString:self.userDefaults.backgroundImage]) {
        imageView.layer.borderWidth = 5;
    } else {
        imageView.layer.borderWidth = 0;
    }
}

- (void)changeImage:(UITapGestureRecognizer *)tapGesture {
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    NSString *imageName = [NSString stringWithFormat:@"fondo%u", [self.imagesArray indexOfObject:imageView] + 1];
    self.userDefaults.backgroundImage = imageName;
}

@end
