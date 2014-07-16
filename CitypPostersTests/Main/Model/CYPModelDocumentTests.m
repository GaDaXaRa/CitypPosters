//
//  CYPModelDocumentTests.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 14/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//


#import <XCTest/XCTest.h>
//#import <OCMock/OCMock.h>
#import "CYPModelDocument.h"
#import "CYPArtist+Model.h"
#import "CYPVenue+Model.h"
#import "CYPEvent+Model.h"
#import "CYPCity+Model.h"

static NSString *const ironMaiden = @"Iron Maiden";
static NSString *const leonardoDantes = @"Leonardo Dantés";
static NSString *const venueName = @"Sala Caracol";
static NSString *const venueAddress = @"Calle Valencia, 7";
static NSString *const venueCityName = @"Madrid";
static NSString *const venueCityCountry = @"Spain";
static NSString *const firstEventName = @"1000 nombres para eso";
static NSString *const secondEventName = @"Metallica 30 Aniversary Tour";
static NSString *const heavyMetal = @"Heavy Metal";
static NSString *const coplaFreak = @"Copla Freak";
static NSString *const rock = @"Rock";

@interface CYPModelDocumentTests : XCTestCase {
    // Core Data stack objects.
    NSManagedObjectModel *model;
    NSPersistentStoreCoordinator *coordinator;
    NSPersistentStore *store;
    NSManagedObjectContext *context;
    // Object to test.
    CYPModelDocument *sut;
    
    NSNumber *latitude;
    NSNumber *longitude;
    NSNumber *venueZIP;
    
    NSDictionary *cityDictionary;
    NSDictionary *venueDictionary;
    NSDictionary *mainArtistsDictionary;
    NSDictionary *invitedArtistsDictionary;
    NSDictionary *firstEventDictionary;
    NSDictionary *secondEventDictionary;
    
    NSDate *firstDate;
    NSDate *secondDate;
    
    NSArray *eventsArray;
}

@end


@implementation CYPModelDocumentTests

#pragma mark - Basic test

- (void) testObjectIsNotNil {
    XCTAssertNotNil(sut, @"The object to test must be created in setUp.");
}

- (void) testMOCAssignment {
    XCTAssertEqualObjects(sut.managedObjectContext, context,
                          @"Managed object context must be injected for other tests to work.");
}

- (void) testAceptanceWithTwoEventsOneWithoutInvitedShouldReturnOrderedByDate {
    [sut importDataWithEvents:eventsArray error:NULL];
    
    NSArray *results = [context executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([CYPEvent class])]
                                              error:NULL];
    
    XCTAssertTrue(results.count == 2, @"Results should have two events");
}

- (void) testLoadDataFromUrl {
    NSURL *url = [NSURL URLWithString:@"http://citypposters.apiary.io/events"];
    [sut importDataWithUrl:url completion:^(BOOL error) {
        XCTAssertFalse(error, @"Should not end with error");
        NSArray *results = [context executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([CYPEvent class])]
                                                  error:NULL];
        XCTAssertNotNil(results, @"Must return results");
    }];
}

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
    context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    context.persistentStoreCoordinator = coordinator;
}

- (void) createFixture {
    firstDate = [NSDate dateWithTimeIntervalSinceNow:24*60*60];
    secondDate = [NSDate dateWithTimeIntervalSinceNow:2*24*60*60];
    venueZIP = @28012;
    latitude = [NSNumber numberWithDouble:40.404039];
    longitude = [NSNumber numberWithDouble:-3.700111];
    cityDictionary = @{cityNameKey: venueCityName, cityCountryKey: venueCityCountry};
    venueDictionary = @{venueKey: @[@{venueNameKey: venueName, venueAddressKey: venueAddress, venueLatitudeKey: latitude, venueLongitudeKey: longitude, venueZipKey: venueZIP, venueCityKey: cityDictionary}]};
    mainArtistsDictionary =  @{mainArtistsKey: @[@{artistPropertyName: leonardoDantes}]};
    invitedArtistsDictionary = @{invitedArtistsKey: @[@{artistPropertyName: ironMaiden}]};
    
    firstEventDictionary = @{eventNameKey: firstEventName, venueKey: venueDictionary, mainArtistsKey: @[mainArtistsDictionary], invitedArtistsKey: @[invitedArtistsDictionary], eventDatesKey: @[firstDate, secondDate], genresKey:@[coplaFreak]};
    
    secondEventDictionary = @{eventNameKey: firstEventName, venueKey: venueDictionary, mainArtistsKey: @[invitedArtistsDictionary], eventDatesKey: @[secondDate], genresKey:@[heavyMetal, rock]};
    
    eventsArray = @[secondEventDictionary, firstEventDictionary];
}

- (void) createSut {
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                             inDomains:NSUserDomainMask] lastObject];
    NSURL *fakeURL = [docsURL URLByAppendingPathComponent:@"nofile"];
    sut = [[CYPModelDocument alloc] initWithFileURL:fakeURL];
    [sut setValue:context forKeyPath:@"managedObjectContext"];
    
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
    venueZIP = nil;
    latitude = nil;
    longitude = nil;
    cityDictionary = nil;
    mainArtistsDictionary = nil;
    invitedArtistsDictionary = nil;
    firstEventDictionary = nil;
    secondEventDictionary = nil;
    
    eventsArray = nil;
}

- (void) releaseCoreDataStack {
    context = nil;
    store = nil;
    coordinator = nil;
    model = nil;
}

@end
