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
#import "CYPEvent+Model.h"
#import "CYPFetchResultControllerManager.h"
#import "CYPEventManager.h"
#import "CYPPosterCell.h"
#import "CYPCoordinatorViewController.h"
#import "CYPUserDefaultsManager.h"
#import "CYPFlowLayoutHelper.h"

enum {
    inPoster,
    zoomInScreen,
    zoomInPoster
}; typedef NSUInteger ScreenState;

@interface CYPMainScreenViewController ()<UICollectionViewDelegate, CYPDetailViewControllerDelegate>

@property (strong, nonatomic) IBOutlet CYPViewAnimationHelper *animationHelper;
@property (strong, nonatomic) IBOutlet CYPFetchResultControllerManager *fetchResultControllerManager;
@property (strong, nonatomic) IBOutlet CYPUserDefaultsManager *userDefaults;
@property (strong, nonatomic) IBOutlet CYPEventManager *eventManager;
@property (strong, nonatomic) IBOutlet CYPFlowLayoutHelper *layoutHelper;

@property (weak, nonatomic) IBOutlet UICollectionView *posterCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *calendarSegmentedControl;
@property (strong, nonatomic) IBOutlet CYPPosterCollectionDatasource *collectionDatasource;
@property (weak, nonatomic) IBOutlet UIImageView *noResultsImage;

@property (strong, nonatomic) CYPDetailViewController *detailViewController;

@property (nonatomic) ScreenState screenState;

@property (nonatomic) BOOL calendarEnabled;

@end

@implementation CYPMainScreenViewController

- (CYPDetailViewController *)detailViewController {
    if(!_detailViewController) {
        _detailViewController = [[UIStoryboard storyboardWithName:@"Posters_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"detailViewController"];
        _detailViewController.delegate = self;
    }
    
    return _detailViewController;
}

- (IBAction)pich:(UIPinchGestureRecognizer *)sender {
    if (sender.scale < 1) {
        [self performPinchIn];
    } else {
        [self performPinchOut];
    }
}

- (IBAction)calendarControlChanged:(UISegmentedControl *)sender {
    self.userDefaults.selectedCalendar = sender.selectedSegmentIndex;
}

- (void)performPinchOut {
    if (self.screenState == zoomInScreen) {
        [self layoutFullScreen];
        self.screenState = inPoster;
    }
}

- (void)performPinchIn {
    if (self.screenState == inPoster) {
        [self layoutZoom];
        self.screenState = zoomInScreen;
    }
}

- (void)layoutFullScreen {
    [self.posterCollectionView setCollectionViewLayout:[self.layoutHelper fullScreenFlowLayoutWithItemSize:self.posterCollectionView.frame.size] animated:YES];
    self.posterCollectionView.pagingEnabled = YES;
}

- (void)layoutZoom {
    [self.posterCollectionView setCollectionViewLayout:[self.layoutHelper zoomFlowLayoutWithItemSize:self.posterCollectionView.frame.size] animated:YES];
    self.posterCollectionView.pagingEnabled = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.calendarEnabled = YES;
    [self configureDataSourceBlocks];
    self.noResultsImage.alpha = 0;
    UIFont *font = [UIFont fontWithName:@"Avenir-Medium" size:13];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.calendarSegmentedControl setTitleTextAttributes:attributes
                                                 forState:UIControlStateNormal];
    
    self.title = @"CityPosters";
    
    self.imageView.image = [UIImage imageNamed:self.userDefaults.backgroundImage];
    self.calendarSegmentedControl.selectedSegmentIndex = self.userDefaults.selectedCalendar;
    [self.userDefaults notifyBackgroundChangesWithBlock:^(NSString *newImageName) {
        self.imageView.image = [UIImage imageNamed:self.userDefaults.backgroundImage];
    }];
    
    self.settingsBarButton.target = nil;
    self.settingsBarButton.action = NSSelectorFromString(@"showSettings");
    
    self.fetchResultControllerManager.fetchedResultsDelegate.collectionView = self.posterCollectionView;
    self.fetchResultControllerManager.model = self.model;
    self.collectionDatasource.fetchedResultController = self.fetchResultControllerManager.fetchedResultsController;
    [self.eventManager getAllEventsWithCompletion:^(NSArray *events) {
        dispatch_async(MAIN_QUEUE, ^{
            [self.model importEvents:events];
        });
    }];
    self.posterCollectionView.delegate = self;
    self.posterCollectionView.dataSource = self.collectionDatasource;
    
    __weak typeof(self) bself = self;
    [self.eventManager setImageDidPersistBlock:^(NSString *eventId, UIImage *image) {
        dispatch_async(MAIN_QUEUE, ^{
            [bself updateImage:image forEventId:eventId];
        });
    }];
    
    self.screenState = inPoster;
}

- (void)configureDataSourceBlocks {
    __weak typeof(self) bself = self;
    [self.collectionDatasource setHasResultsBlock:^{
        [bself.animationHelper animateViewFadeOut:bself.noResultsImage inRect:bself.noResultsImage.frame completion:nil];
    }];
    [self.collectionDatasource setNoResultsBlock:^{
        CGRect rect = CGRectInset(bself.posterCollectionView.frame, 20, 0);
        [bself.animationHelper animateViewFadeIn:bself.noResultsImage inRect:rect completion:nil];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [self layoutFullScreen];
}

- (void)updateImage:(UIImage *)image forEventId:(NSString *)eventId {
    CYPEvent *event = [self.model fetchEventById:eventId];
    NSIndexPath *indexPath = [self.fetchResultControllerManager.fetchedResultsController indexPathForObject:event];
    if (indexPath) {
        [self.collectionDatasource imageDidUpdated:image forEventId:eventId];
        [self.posterCollectionView reloadItemsAtIndexPaths:@[indexPath]];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.screenState == zoomInScreen) {
        [self layoutFullScreen];
        [self.posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
        self.screenState = inPoster;
    } else if (self.screenState == inPoster) {
        [self openDetailForItemAtIndexPath:indexPath];
    }
}

- (void)openDetailForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYPEvent *event = [self.fetchResultControllerManager.fetchedResultsController objectAtIndexPath:indexPath];
    self.detailViewController.event = event;
    [self detailControllerWillOpen];
    CGRect rect = CGRectInset(self.posterCollectionView.frame, 20, 0);
    [self.animationHelper animateViewFadeIn:self.detailViewController.view inRect:rect completion:^{
        [self.detailViewController didMoveToParentViewController:self];
        if (self.calendarEnabled) {
            [self.animationHelper animateViewFadeOut:self.calendarSegmentedControl inRect:self.calendarSegmentedControl.frame completion:nil];
        }
    }];
}

- (void)detailControllerWillOpen {
    [self.detailViewController willMoveToParentViewController:self];
    [self addChildViewController:self.detailViewController];;
    [self.view addSubview:self.detailViewController.view];
    self.posterCollectionView.userInteractionEnabled = NO;
    self.calendarSegmentedControl.userInteractionEnabled = NO;
}

- (void)closeDetailView:(UIView *)view withCompletion:(void(^)())completion {
    [self.detailViewController willMoveToParentViewController:nil];
    UIView *detailView = self.detailViewController.view;
    [self.animationHelper animateViewFadeOut:self.detailViewController.view inRect:view.frame completion:^{
        [self detailControlDidClose:detailView];
        if (self.calendarEnabled) {
            [self.animationHelper animateViewFadeIn:self.calendarSegmentedControl inRect:self.calendarSegmentedControl.frame completion:nil];
        }
        if (completion) {
            completion();
        }
    }];
}

- (void)detailControlDidClose:(UIView *)detailView {
    [detailView removeFromSuperview];
    [self.detailViewController removeFromParentViewController];
    [self.detailViewController didMoveToParentViewController:nil];
    self.posterCollectionView.userInteractionEnabled = YES;
    self.calendarSegmentedControl.userInteractionEnabled = YES;
}

- (void)detailViewControllerFished:(CYPDetailViewController *)controller {
    self.calendarEnabled = YES;
    [self closeDetailView:controller.view withCompletion:nil];
}

- (void)detailViewControllerNextDetail:(CYPDetailViewController *)controller {
    NSIndexPath *indexPath = [[self.posterCollectionView indexPathsForVisibleItems] firstObject];
    
    if(indexPath.row != [self.posterCollectionView numberOfItemsInSection:indexPath.section] -1) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
        [self moveCollectionView:self.posterCollectionView detailView:controller.view ToIndexPath:newIndexPath];
    }
    
}

- (void)detailViewControllerPreviousDetail:(CYPDetailViewController *)controller {
    NSIndexPath *indexPath = [[self.posterCollectionView indexPathsForVisibleItems] firstObject];
    if (indexPath.row > 0) {
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
        [self moveCollectionView:self.posterCollectionView detailView:controller.view ToIndexPath:newIndexPath];
    }
}

- (void)moveCollectionView:(UICollectionView *)collectionView detailView:(UIView *)view ToIndexPath:(NSIndexPath *)indexPath {
    self.calendarEnabled = NO;
    [self.posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    [self closeDetailView:view withCompletion:^{
        [self openDetailForItemAtIndexPath:indexPath];
    }];
}

@end
