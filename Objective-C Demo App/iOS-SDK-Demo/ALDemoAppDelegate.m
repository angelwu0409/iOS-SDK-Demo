//
//  ALDemoAppDelegate.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 12/23/16.
//  Copyright (c) 2016 AppLovin. All rights reserved.
//

#import "ALDemoAppDelegate.h"
#import <AppLovinSDK/AppLovinSDK.h>

@implementation ALDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[ALSdk shared] initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
        // SDK finished initialization
    }];
    
    // Mark that we are in a testing environment
    [ALSdk shared].settings.isTestAdsEnabled = YES;
    
    // Set an identifier for the current user. This identifier will be tied to various analytics events and rewarded video validation
    [ALSdk shared].userIdentifier = @"support@applovin.com";
    
    [[UINavigationBar appearance] setTranslucent: NO];
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed: 10.0f/255.0f green: 131.0f/255.f blue: 170.0f/255.0f alpha: 1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor: [UIColor whiteColor]];
    
    return YES;
}

@end
