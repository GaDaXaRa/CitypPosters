//
//  CYPMainScreenViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPMainScreenViewController.h"
#import "CYPPosterCollectionDatasource.h"
#import "CYPCollectionViewDelegateFlowLayout.h"

@interface CYPMainScreenViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *posterCollectionView;
@property (strong, nonatomic) CYPPosterCollectionDatasource *collectionDatasource;
@property (strong, nonatomic) CYPCollectionViewDelegateFlowLayout *delegateFlowLayout;

@end

@implementation CYPMainScreenViewController

- (CYPPosterCollectionDatasource *)collectionDatasource {
    if(!_collectionDatasource) {
        _collectionDatasource = [[CYPPosterCollectionDatasource alloc] init];
    }
    
    return _collectionDatasource;
}

- (CYPCollectionViewDelegateFlowLayout *)delegateFlowLayout {
    if(!_delegateFlowLayout) {
        _delegateFlowLayout = [[CYPCollectionViewDelegateFlowLayout alloc] init];
    }
    
    return _delegateFlowLayout;
}

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
    self.posterCollectionView.dataSource = self.collectionDatasource;
    self.posterCollectionView.delegate = self.delegateFlowLayout;
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
