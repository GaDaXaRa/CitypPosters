//
//  CYPMainScreenViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPMainScreenViewController.h"
#import "CYPPosterCollectionDatasource.h"
#import "CYPDetailViewController.h"
#import "CYPViewAnimationHelper.h"

enum {
    inPoster,
    zoomInScreen,
    zoomInPoster
}; typedef NSUInteger ScreenState;

@interface CYPMainScreenViewController ()<UICollectionViewDelegate, CYPDetailViewControllerDelegate>

@property (strong, nonatomic) IBOutlet CYPViewAnimationHelper *animationHelper;
@property (weak, nonatomic) IBOutlet UICollectionView *posterCollectionView;
@property (strong, nonatomic) CYPPosterCollectionDatasource *collectionDatasource;
@property (strong, nonatomic) UICollectionViewFlowLayout *fullScreenLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *zoomOutLayout;
@property (strong, nonatomic) CYPDetailViewController *detailViewController;

@property (nonatomic) ScreenState screenState;

@end

@implementation CYPMainScreenViewController

- (CYPDetailViewController *)detailViewController {
    if(!_detailViewController) {
        _detailViewController = [[UIStoryboard storyboardWithName:@"Posters_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"detailViewController"];
        _detailViewController.delegate = self;
    }
    
    return _detailViewController;
}

- (UICollectionViewFlowLayout *)fullScreenLayout {
    if (!_fullScreenLayout) {
        _fullScreenLayout = [[UICollectionViewFlowLayout alloc] init];
        _fullScreenLayout.itemSize = CGSizeMake(self.posterCollectionView.frame.size.width, self.posterCollectionView.frame.size.height );
        _fullScreenLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _fullScreenLayout.minimumInteritemSpacing = 0;
        _fullScreenLayout.minimumLineSpacing = 0;
        _fullScreenLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _fullScreenLayout;
}

- (UICollectionViewFlowLayout *)zoomOutLayout {
    if (!_zoomOutLayout) {
        _zoomOutLayout = [[UICollectionViewFlowLayout alloc] init];
        _zoomOutLayout.itemSize = CGSizeMake(self.posterCollectionView.frame.size.width / 2, self.posterCollectionView.frame.size.height / 2);
        _zoomOutLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _zoomOutLayout.minimumInteritemSpacing = 0;
        _zoomOutLayout.minimumLineSpacing = 0;
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
    self.posterCollectionView.delegate = self;
    self.screenState = inPoster;
    self.posterCollectionView.dataSource = self.collectionDatasource;
    self.posterCollectionView.collectionViewLayout = self.fullScreenLayout;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.screenState == zoomInScreen) {
        [self performPinchOut];
        [self.posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.screenState == zoomInScreen) {
        [self.posterCollectionView setCollectionViewLayout:self.fullScreenLayout animated:YES completion:^(BOOL finished) {
            [self.posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            self.screenState = inPoster;
        }];
    } else if (self.screenState == inPoster) {
        [self openDetailForItemAtIndexPath:indexPath];
    }
}

- (void)openDetailForItemAtIndexPath:(NSIndexPath *)indexPath {
    [self addChildViewController:self.detailViewController];
    [self.detailViewController willMoveToParentViewController:self];
    [self.view addSubview:self.detailViewController.view];
    self.posterCollectionView.userInteractionEnabled = NO;
    [self.animationHelper animateViewFromLeft:self.detailViewController.view inRect:self.posterCollectionView.frame completion:^{
        [self.detailViewController didMoveToParentViewController:self];
        self.posterCollectionView.userInteractionEnabled = YES;
    }];
}

- (void)closeDetailView {
    [self.detailViewController willMoveToParentViewController:nil];
    UIView *detailView = self.detailViewController.view;
    self.posterCollectionView.userInteractionEnabled = NO;
    [self.animationHelper animateViewToRight:self.detailViewController.view inRect:self.posterCollectionView.frame completion:^{
        [detailView removeFromSuperview];
        [self.detailViewController removeFromParentViewController];
        self.posterCollectionView.userInteractionEnabled = YES;
    }];
}

- (void)detailViewControllerFished:(CYPDetailViewController *)controller {
    [self closeDetailView];
}

@end
