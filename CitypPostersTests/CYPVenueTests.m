//
//  CYPVenueTests.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//


#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
#import "CYPVenue.h"
#import "CYPCity.h"

static NSString *const VENUE_NAME = @"Sala Caracol";
static NSString *const VENUE_CITY = @"Madrid";
static NSString *const VENUE_ADDRESS = @"Calle Valencia, 7";
static NSString *const VENUE_COUNTRY = @"Spain";


@interface CYPVenueTests : XCTestCase {
    // Core Data stack objects.
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    // Object to test.
    CYPVenue *sut;
    NSNumber *venueZIP;
    NSNumber *latitude;
    NSNumber *longitude;
}

@end


@implementation CYPVenueTests

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
    venueZIP = @28012;
    latitude = [NSNumber numberWithDouble:40.404039];
    longitude = [NSNumber numberWithDouble:-3.700111];
}


- (void) createSut {
    sut = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPVenue class]) inManagedObjectContext:context];
    sut.name = VENUE_NAME;
    sut.city = [self buildCity];
    sut.address = VENUE_ADDRESS;
    sut.zip = venueZIP;
    sut.country = VENUE_COUNTRY;
    sut.latitude = latitude;
    sut.longitude = longitude;
    [context save:NULL];
}

- (CYPCity *)buildCity {
    CYPCity *city = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPCity class]) inManagedObjectContext:context];
    city.name = VENUE_CITY;
    city.country = VENUE_COUNTRY;
    
    return city;
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

- (void) testVenueShouldHaveAName {
    XCTAssertNotNil(sut.name, @"Venue should have a name");
    XCTAssertEqualObjects(VENUE_NAME, sut.name, @"Venue name should be %@", VENUE_NAME);
}

- (void) testVenueShouldHaveACity {
    CYPCity *city = (CYPCity *)sut.city;
    XCTAssertNotNil(city, @"Venue should have a name");
    XCTAssertEqualObjects(VENUE_CITY, city.name, @"Venue name should be %@", VENUE_CITY);
    XCTAssertEqualObjects(VENUE_COUNTRY, city.country, @"Venue name should be %@", VENUE_COUNTRY);
}

- (void) testVenueShouldHaveAddress {
    XCTAssertNotNil(sut.address, @"Venue should have a name");
    XCTAssertEqualObjects(VENUE_ADDRESS, sut.address, @"Venue name should be %@", VENUE_ADDRESS);
}

- (void) testVenueShouldHaveZIPCode {
    XCTAssertNotNil(sut.zip, @"Venue should have a ZIP Code");
    XCTAssertEqualObjects(venueZIP, sut.zip, @"Venue ZIP should be %@", venueZIP);
}

- (void) testVenueShouldHaveCountry {
    XCTAssertNotNil(sut.country, @"Venue should have a ZIP Code");
    XCTAssertEqualObjects(VENUE_COUNTRY, sut.country, @"Venue ZIP should be %@", VENUE_COUNTRY);
}

- (void) testShouldHaveLatitudeAndLongitude {
    XCTAssertEqualObjects(latitude, sut.latitude, @"Latitude should equals %@", latitude);
    XCTAssertEqualObjects(longitude, sut.longitude, @"Latitude should equals %@", longitude);
}

@end
