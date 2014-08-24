//
//  CYPEventTests.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//


#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "CYPEvent.h"
#import "CYPDates.h"
#import "CYPEvent.h"
#import "CYPArtist.h"
#import "CYPVenue.h"
#import "CYPGenre.h"
#import "CYPCity.h"

static NSString *const EVENT_NAME = @"Mega event";
static NSString *const GENRE_ROCK = @"Rock";
static NSString *const GENRE_HEAVY_METAL = @"Heavy Metal";
static NSString *const EVENT_ID = @"Fixture eventId";

@interface CYPEventTests : XCTestCase {
    // Core Data stack objects.
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    // Object to test.
    CYPEvent *sut;
    NSSet *genres;
    NSSet *artists;
    NSSet *dates;
    CYPVenue *eventVenue;
}

@end


@implementation CYPEventTests

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
    [self buildVenue];
    [self buildGroups];
    [self buildDates];
    [self buildGenres];
}


- (void) createSut {
    sut = [NSEntityDescription insertNewObjectForEntityForName:@"CYPEvent" inManagedObjectContext:context];
    sut.name = EVENT_NAME;
    sut.genres = genres;
    sut.mainArtists = artists;
    sut.invitedArtists = artists;
    sut.dates = dates;
    sut.eventId = EVENT_ID;
    sut.venue = eventVenue;
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
    dates = nil;
    genres = nil;
    artists = nil;
    eventVenue = nil;
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

- (void)testEventCanHaveMoreThanOneDate {
    NSSet *eventDates = sut.dates;
    
    XCTAssertNotNil(eventDates, @"Event should have dates");
    XCTAssertTrue([eventDates count] == 2, @"Event should have two dates");
}

- (void) testShouldHaveMainGroups {
    NSSet *mainGroups = sut.mainArtists;
    
    XCTAssertNotNil(mainGroups, @"Event should have main groups");
    XCTAssertTrue([mainGroups count] == 2, @"Event should have two main groups");
}

- (void) testCanHaveInvitedArtists {
    NSSet *invitedArtists = sut.invitedArtists;
    
    XCTAssertNotNil(invitedArtists, @"Event should have invited artists");
    XCTAssertTrue([invitedArtists count] == 2, @"Event should have two invited artists");
}

- (void) testEventShouldHaveName {
    XCTAssertEqualObjects(EVENT_NAME, sut.name, @"Event name must be %@", EVENT_NAME);
}

- (void) testEventShouldHaveAVenue {
    
    XCTAssertNotNil(sut.venue, @"Event should have a venue");
}

- (void) testEventShouldHaveMusicGenres {
    NSArray *genresArray = [sut.genres allObjects];
    
    XCTAssertNotNil(genresArray, @"Event should have music genres");
    XCTAssertTrue([genresArray count] == 2, @"Event should have 2 genres");
    XCTAssertTrue([genresArray[0] name] == GENRE_ROCK || [genresArray[0] name] == GENRE_HEAVY_METAL, @"Event should contain %@", GENRE_ROCK);
}

- (void)testEventShouldHaveAnUUID {
    XCTAssertNotNil(sut.eventId, @"Event should have an eventId");
}

#pragma mark -
#pragma mark Create fixture methods

- (void) buildGenres {
    CYPGenre *rock = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPGenre class]) inManagedObjectContext:context];
    rock.name = GENRE_ROCK;
    
    CYPGenre *heavyMetal = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPGenre class]) inManagedObjectContext:context];
    heavyMetal.name = GENRE_HEAVY_METAL;
    
    genres = [NSSet setWithObjects:rock, heavyMetal, nil];
}

- (void)buildDates {
    CYPDates *tomorrowDate = [NSEntityDescription insertNewObjectForEntityForName:@"CYPDates" inManagedObjectContext:context];
    CYPDates *twoDaysDate = [NSEntityDescription insertNewObjectForEntityForName:@"CYPDates" inManagedObjectContext:context];
    dates = [NSSet setWithObjects:tomorrowDate, twoDaysDate, nil];
}

- (void) buildGroups {
    CYPArtist *ironMaiden = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPArtist class]) inManagedObjectContext:context];
    ironMaiden.name = @"Iron Maiden";
    
    CYPArtist *metallica = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPArtist class]) inManagedObjectContext:context];
    metallica.name = @"Metallica";
    
    artists = [NSSet setWithObjects:ironMaiden, metallica, nil];
}

- (void) buildVenue {
    
    eventVenue = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPVenue class]) inManagedObjectContext:context];
    eventVenue.name = @"Sala Caracol";
    eventVenue.address = @"Calle Valencia, 7";
    eventVenue.zip = @28012;
    eventVenue.city = [self buildCity];
}

- (CYPCity *)buildCity {
    CYPCity *city = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([CYPCity class]) inManagedObjectContext:context];
    city.name = @"Madrid";
    city.country = @"Spain";
    
    return city;
}

@end
