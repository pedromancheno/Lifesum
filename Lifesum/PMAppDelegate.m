//
//  PMAppDelegate.m
//  Lifesum
//
//  Created by Pedro Mancheno on 5/24/14.
//  Copyright (c) 2014 Pedro Mancheno. All rights reserved.
//

#import "PMAppDelegate.h"

#import "PMCoreDataHelper.h"

#import "PMAPIClient.h"

@implementation PMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[PMCoreDataHelper sharedInstance] setupCoreDataStack];
    
    [[PMAPIClient sharedClient] foodWithCompletion:^(BOOL success, NSArray *objects, NSError *error) {
        if (!success) {
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                       message:NSLocalizedString(@"There was an error trying to load food remotely", nil)
                                      delegate:self
                             cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                             otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
    
    [[PMAPIClient sharedClient] exercisesWithCompletion:^(BOOL success, NSArray *objects, NSError *error) {
        if (!success) {
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                       message:NSLocalizedString(@"There was an error trying to load exercises remotely", nil)
                                      delegate:self
                             cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                             otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
    
    [[PMAPIClient sharedClient] categoriesWithCompletion:^(BOOL success, NSArray *objects, NSError *error) {
        if (!success) {
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                       message:NSLocalizedString(@"There was an error trying to load categories remotely", nil)
                                      delegate:self
                             cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                             otherButtonTitles:nil];
            
            [alertView show];
        }
    }];
    
    // UIAppearance
    [[UITabBar appearance] setTintColor:[UIColor blueColor]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
