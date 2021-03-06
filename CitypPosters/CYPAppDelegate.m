//
//  CYPAppDelegate.m
//  CitypPosters
//
//  Created by Miguel Santiago Rodríguez on 13/07/14.
//  Copyright (c) 2014 gadaxara. All rights reserved.
//

#import "CYPAppDelegate.h"
#import "CYPModelDocument.h"
#import "CYPCoordinatorViewController.h"
#import "CYPUserDefaultsManager.h"
#import "CYPNotificationCenterDefaultsManager.h"

@interface CYPAppDelegate ()

@property (strong, nonatomic) CYPModelDocument *model;
@property (strong, nonatomic) CYPNotificationCenterDefaultsManager *notificationToUserDefaults;

@end

@implementation CYPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self prepareUserDefaults];
    [self prepareRootController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)prepareRootController {
    CYPCoordinatorViewController *mainController = (CYPCoordinatorViewController *)self.window.rootViewController;
    mainController.model = self.model;
}

- (void)prepareUserDefaults {
    self.notificationToUserDefaults = [[CYPNotificationCenterDefaultsManager alloc] init];
    CYPUserDefaultsManager *userDefaults = [[CYPUserDefaultsManager alloc] init];
    if (!userDefaults.backgroundImage) {
        userDefaults.backgroundImage = @"fondo1";
    }
}

#pragma mark - Core Data stack

- (CYPModelDocument *)model {
    if (!_model) {
        NSURL *modelUrl = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CYPModel.model"];
        _model = [[CYPModelDocument alloc] initWithFileURL:modelUrl];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[modelUrl path]]) {
            [self.model openWithCompletionHandler:^(BOOL success) {
                if (!success) {
                    //ERROR
                    NSLog(@"error1");
                }
            }];
        } else {
            [_model saveToURL:modelUrl forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                if (!success) {
                    //ERROR
                    NSLog(@"error2");
                }
            }];
        }
    }
    
    return _model;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
