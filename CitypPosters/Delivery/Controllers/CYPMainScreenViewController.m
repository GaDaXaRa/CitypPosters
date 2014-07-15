//
//  CYPMainScreenViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPMainScreenViewController.h"
#import "CYPPosterCollectionDatasource.h"

@interface CYPMainScreenViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *posterCollectionView;
@property (strong, nonatomic) CYPPosterCollectionDatasource *collectionDatasource;
@property (strong, nonatomic) UICollectionViewFlowLayout *fullScreenLayout;
@property (strong, nonatomic) UICollectionViewFlowLayout *zoomOutLayout;

@end

@implementation CYPMainScreenViewController

- (UICollectionViewFlowLayout *)fullScreenLayout {
    if (!_fullScreenLayout) {
        _fullScreenLayout = [[UICollectionViewFlowLayout alloc] init];
        _fullScreenLayout.itemSize = CGSizeMake(self.posterCollectionView.frame.size.width - 10, self.posterCollectionView.frame.size.height - 10);
        _fullScreenLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return _fullScreenLayout;
}

- (UICollectionViewFlowLayout *)zoomOutLayout {
    if (!_zoomOutLayout) {
        _zoomOutLayout = [[UICollectionViewFlowLayout alloc] init];
        _zoomOutLayout.itemSize = CGSizeMake(self.posterCollectionView.frame.size.width / 2 -10, self.posterCollectionView.frame.size.height / 2 - 10);
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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)pich:(UIPinchGestureRecognizer *)sender {
    if (sender.scale < 1) {
        [self performPinchIn];
    } else {
        [self performPinchOut];
    }
}

- (void)performPinchOut {
    [self.posterCollectionView setCollectionViewLayout:self.fullScreenLayout animated:YES];
}

- (void)performPinchIn {
    [self.posterCollectionView setCollectionViewLayout:self.zoomOutLayout animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.posterCollectionView.dataSource = self.collectionDatasource;
    self.posterCollectionView.collectionViewLayout = self.fullScreenLayout;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
