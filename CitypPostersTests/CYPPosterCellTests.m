//
//  CYPPosterCellTests.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CYPPosterCell.h"

@interface CYPPosterCellTests : XCTestCase

@property CYPPosterCell *sut;

@end

@implementation CYPPosterCellTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testWidhtShouldBeGreaterThan48 {
    self.sut = [[CYPPosterCell alloc] initWithFrame:CGRectMake(0, 0, 640, 960)];
    
    XCTAssertTrue(self.sut.contentView.bounds.size.width > 48, @"With must be greater than 48");
}

- (void)testShouldHaveAnAspectRatioOfTwoThirds {
    self.sut = [[CYPPosterCell alloc] initWithFrame:CGRectMake(0, 0, 640, 960)];
    
    NSUInteger widthRatio = self.sut.contentView.bounds.size.width / 2;
    NSUInteger heightRatio = self.sut.contentView.bounds.size.height / 3;
    
    XCTAssertEqual(widthRatio, heightRatio, @"Should mantain 2:3 aspect ratio");
}

- (void)testShouldHaveAnAspectRatioOfTwoThirdsForiPhone5 {
    self.sut = [[CYPPosterCell alloc] initWithFrame:CGRectMake(0, 0, 1136, 640)];
    
    NSUInteger widthRatio = self.sut.contentView.bounds.size.width / 2;
    NSUInteger heightRatio = self.sut.contentView.bounds.size.height / 3;
    
    XCTAssertEqual(widthRatio, heightRatio, @"Should mantain 2:3 aspect ratio");
}

@end
