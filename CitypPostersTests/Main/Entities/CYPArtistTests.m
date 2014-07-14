//
//  CYPArtistTests.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//


#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
#import "CYPArtist.h"


@interface CYPArtistTests : XCTestCase {
    // Core Data stack objects.
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    // Object to test.
    CYPArtist *sut;
}

@end


@implementation CYPArtistTests

#pragma mark - Set up and tear down

- (void) setUp {
    [super setUp];

    [self createCoreDataStack];
    [self createFixture];
    [self createSut];
}


- (void) createCoreDataStack {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    model = [NSManagedObjectModel mergedModelFromBundles:@[bundle]];
    coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    store = [coordinator addPersistentStoreWithType: NSInMemoryStoreType
                                      configuration: nil
                                                URL: nil
                                            options: nil
                                              error: NULL];
    context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = coordinator;
}


- (void) createFixture {
    // Test data
}


- (void) createSut {
    sut = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPArtist class]) inManagedObjectContext:context];
    [context save:NULL];
}


- (void) tearDown {
    [self releaseSut];
    [self releaseFixture];
    [self releaseCoreDataStack];

    [super tearDown];
}


- (void) releaseSut {
    sut = nil;
}


- (void) releaseFixture {

}


- (void) releaseCoreDataStack {
    context = nil;
    store = nil;
    coordinator = nil;
    model = nil;
}


#pragma mark - Basic test

- (void) testObjectIsNotNil {
    XCTAssertNotNil(sut, @"The object to test must be created in setUp.");
}

- (void) testArtistShouldHaveAnArtistId {
    XCTAssertNotNil(sut.artistId, @"Artist should have an artist id");
}

@end
