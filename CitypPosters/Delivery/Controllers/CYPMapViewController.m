//
//  CYPMapViewController.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 22/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPMapViewController.h"
#import <MapKit/MapKit.h>
#import "CYPVenue+Annotation.h"

@interface CYPMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation CYPMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.map setShowsPointsOfInterest:NO];
    [self addVenueAnnotation:self.event.venue];
    [self centerMapInInVenue:self.event.venue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)addVenueAnnotation:(CYPVenue *)venue {
    [self.map addAnnotation:venue];
    [self.map selectAnnotation:venue animated:YES];
}

- (void)centerMapInInVenue:(CYPVenue *)venue {
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(venue.coordinate, 3000.0, 3000.0);
    MKCoordinateRegion fitRegion = [self.map regionThatFits:viewRegion];
    [self.map setRegion:fitRegion animated:YES];
}

@end
