//
//  AppDelegate.m
//  audiobooks
//
//  Created by Andrei Vidrasco on 3/21/14.
//  Copyright (c) 2014 Andrei Vidrasco. All rights reserved.
//

#import "AppDelegate.h"
#import "Flurry.h"
#import "Apsalar.h"
#import <RevMobAds/RevMobAds.h>
#import "Chartboost.h"
#import "ChartboostDelegates.h"
#import <AskingPoint/AskingPoint.h>
#import "ALSdk.h"
#import "ALInterstitialAd.h"
#import <ADCTracker/ADCTracker.h>
#import <AdColony/AdColony.h>
#import "VFAdsSingleton.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults stringForKey:kLanguage]){
		NSString* preferredLanguage = [NSLocale preferredLanguages][0];
		preferredLanguage = [preferredLanguage isEqualToString:kRussianLanguageTag] ? kRussianLanguageTag : kEnglishLanguageTag;
		[userDefaults setObject:preferredLanguage forKey:kLanguage];
	}
    if (IS_PHONE)
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[LogoViewController alloc] initWithNibName:@"LogoViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [self.navController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navController;
    NSLog(@"%@",[[MKStoreManager sharedManager]purchasableObjectsDescription]);
    ////Reclama
    [Flurry startSession:FlurryKey];
    [Apsalar startSession:AppSalarKey withKey:AppSalarSecret];
    [RevMobAds startSessionWithAppID:RevMobKey];
    
    
    [ASKPManager startup:@"RABuADIBU5CuN0kHNHcmZSlQI-ykmfeHqjmjJaBH3Ws="];
    // AppLovin
    [ALSdk initializeSdk];
    [ALInterstitialAd showOver:[[UIApplication sharedApplication] keyWindow]];

    
    
    [ASKPManager sharedManager].commandHandler = ^BOOL (ASKPCommand *command) {
        if(command.type == ASKPCommandAlert) {
            if(command.alertType == ASKPAlertRating) {
                command.message = NSLocalizedStringWithDefaultValue(
                                                                    @"Neoniks love getting Reviews...:)",
                                                                    nil,
                                                                    [NSBundle mainBundle],
                                                                    command.message,
                                                                    @"Replacing prompt text for some languages."
                                                                    );
                for(ASKPAlertButton *button in command.buttons) {
                    if(button.ratingType == ASKPAlertRatingYes)
                        button.text = NSLocalizedStringWithDefaultValue(
                                                                        @"Rate us 5 stars",
                                                                        nil,
                                                                        [NSBundle mainBundle],
                                                                        button.text,
                                                                        @"Example of replacing button text."
                                                                        );
                }
            }
        }
        // Return NO because you're just changing Message & Button strings
        // in the Command object. By returning NO the default Rating Booster
        // widget uses the Command Object with your text strings.
        return NO;
    };

    ////Stop reclama
    
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    
    // AdColony Tracker SDK
    [ADCTracker startWithAppID:AdColonyAppID
                        userID:@""
                       logging:YES
                       options:nil];
    
    [AdColony configureWithAppID:AdColonyAppID
                         zoneIDs:@[AdColonyOnStartZone]
                        delegate:nil
                         logging:YES];

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
