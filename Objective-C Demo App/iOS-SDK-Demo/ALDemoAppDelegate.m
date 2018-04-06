//
//  ALDemoAppDelegate.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 12/23/16.
//  Copyright (c) 2016 AppLovin. All rights reserved.
//

#import "ALDemoAppDelegate.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALSdk.h"
#endif

@implementation ALDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initializing our SDK at launch is very important as it'll start preloading ads in the background.
    [ALSdk initializeSdk];
    
    [ALSdk shared].settings.isTestAdsEnabled = YES;
    
    [[UINavigationBar appearance] setTranslucent: NO];
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed: 10.0f/255.0f green: 131.0f/255.f blue: 170.0f/255.0f alpha: 1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor: [UIColor whiteColor]];
    return YES;
}

@end
