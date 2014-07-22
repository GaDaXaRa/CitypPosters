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
#import "CYPImageTiler.h"
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

@property (strong, nonatomic) CYPPosterCollectionDatasource *collectionDatasource;
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

- (CYPPosterCollectionDatasource *)collectionDatasource {
    if(!_collectionDatasource) {
        _collectionDatasource = [[CYPPosterCollectionDatasource alloc] init];
        _collectionDatasource.fetchedResultController = self.fetchResultControllerManager.fetchedResultsController;
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
}

- (void)layoutZoom {
    [self.posterCollectionView setCollectionViewLayout:[self.layoutHelper zoomFlowLayoutWithItemSize:self.posterCollectionView.frame.size] animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Citypposters";
    
    self.imageView.image = [CYPImageTiler imgeTiledWithName:self.userDefaults.backgroundImage];
    self.calendarSegmentedControl.selectedSegmentIndex = self.userDefaults.selectedCalendar;
    [self.userDefaults notifyBackgroundChangesWithBlock:^(NSString *newImageName) {
        self.imageView.image = [CYPImageTiler imgeTiledWithName:self.userDefaults.backgroundImage];
    }];
    
    self.settingsBarButton.target = nil;
    self.settingsBarButton.action = NSSelectorFromString(@"showSettings");
    
    self.fetchResultControllerManager.fetchedResultsDelegate.collectionView = self.posterCollectionView;
    self.fetchResultControllerManager.model = self.model;
    [self.eventManager getAllEventsWithCompletion:^(NSArray *events) {
        dispatch_async(MAIN_QUEUE, ^{
            [self.model importEvents:events];
            [self.fetchResultControllerManager changePredicateAndFetch];
        });
    }];
    self.posterCollectionView.delegate = self;
    self.posterCollectionView.dataSource = self.collectionDatasource;
    
    __weak typeof(self) bself = self;
    [self.eventManager setImageDidPersistBlock:^(NSString *eventId) {
        dispatch_async(MAIN_QUEUE, ^{
            [bself updateImageForEventId:eventId];
        });
    }];
        
    self.screenState = inPoster;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [self layoutFullScreen];
}

- (void)updateImageForEventId:(NSString *)eventId {
    CYPEvent *event = [self.model fetchEventById:eventId];
    NSIndexPath *indexPath = [self.fetchResultControllerManager.fetchedResultsController indexPathForObject:event];
    if (indexPath) {
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
    [self.detailViewController willMoveToParentViewController:self];
    [self addChildViewController:self.detailViewController];
    self.detailViewController.event = event;
    [self.view addSubview:self.detailViewController.view];
    self.posterCollectionView.userInteractionEnabled = NO;
    self.calendarSegmentedControl.userInteractionEnabled = NO;
    [self.animationHelper animateViewFadeIn:self.detailViewController.view inRect:self.posterCollectionView.frame completion:^{
        [self.detailViewController didMoveToParentViewController:self];
    }];
}

- (void)closeDetailView:(UIView *)view {
    [self.detailViewController willMoveToParentViewController:nil];
    UIView *detailView = self.detailViewController.view;
    [self.animationHelper animateViewFadeOut:self.detailViewController.view inRect:view.frame completion:^{
        [detailView removeFromSuperview];
        [self.detailViewController removeFromParentViewController];
        [self.detailViewController didMoveToParentViewController:nil];
        self.posterCollectionView.userInteractionEnabled = YES;
        self.calendarSegmentedControl.userInteractionEnabled = YES;
    }];
}

- (void)detailViewControllerFished:(CYPDetailViewController *)controller {
    [self closeDetailView:controller.view];
}

- (void) observeManagedObjectContext {
    [self addObserver:self forKeyPath:@"model.managedObjectContext" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"model.managedObjectContext"]) {
        self.fetchResultControllerManager.fetchedResultsController = nil;
        [self.posterCollectionView reloadData];
    }
}


@end
