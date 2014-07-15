//
//  CYPMainScreenViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPMainScreenViewController.h"
#import "CYPPosterCollectionDatasource.h"

enum {
    inPoster,
    zoomInScreen,
    zoomInPoster
}; typedef NSUInteger ScreenState;

@interface CYPMainScreenViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *posterCollectionView;
@property (strong, nonatomic) CYPPosterCollectionDatasource *collectionDatasource;
@property (strong, nonatomic) UICollectionViewFlowLayout *fullScreenLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *zoomOutLayout;

@property (nonatomic) ScreenState screenState;

@end

@implementation CYPMainScreenViewController

- (UICollectionViewFlowLayout *)fullScreenLayout {
    if (!_fullScreenLayout) {
        _fullScreenLayout = [[UICollectionViewFlowLayout alloc] init];
        _fullScreenLayout.itemSize = CGSizeMake(self.posterCollectionView.frame.size.width - 10, self.posterCollectionView.frame.size.height - 10);
        _fullScreenLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _fullScreenLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _fullScreenLayout;
}

- (UICollectionViewFlowLayout *)zoomOutLayout {
    if (!_zoomOutLayout) {
        _zoomOutLayout = [[UICollectionViewFlowLayout alloc] init];
        _zoomOutLayout.itemSize = CGSizeMake(self.posterCollectionView.frame.size.width / 2 -10, self.posterCollectionView.frame.size.height / 2 - 10);
        _zoomOutLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _zoomOutLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _zoomOutLayout;
}

- (CYPPosterCollectionDatasource *)collectionDatasource {
    if(!_collectionDatasource) {
        _collectionDatasource = [[CYPPosterCollectionDatasource alloc] init];
    }
    
    return _collectionDatasource;
}

- (IBAction)pich:(UIPinchGestureRecognizer *)sender {
    if (sender.scale < 1) {
        [self performPinchIn];
    } else {
        [self performPinchOut];
    }
}

- (void)performPinchOut {
    if (self.screenState == zoomInScreen) {
        [self.posterCollectionView setCollectionViewLayout:self.fullScreenLayout animated:YES];
        self.screenState = inPoster;
    }
}

- (void)performPinchIn {
    if (self.screenState == inPoster) {
        [self.posterCollectionView setCollectionViewLayout:self.zoomOutLayout animated:YES];
        self.screenState = zoomInScreen;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.screenState = inPoster;
    self.posterCollectionView.dataSource = self.collectionDatasource;
    self.posterCollectionView.collectionViewLayout = self.fullScreenLayout;
}

@end
