//
//  ALDemoAppDelegate.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 12/23/16.
//  Copyright (c) 2016 AppLovin. All rights reserved.
//

@import AppLovinSDK;
#import "ALDemoAppDelegate.h"

@implementation ALDemoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initializing our SDK at launch is very important as it'll start preloading ads in the background.
    [ALSdk initializeSdk];
    
    [[UINavigationBar appearance] setTranslucent: NO];
    [[UINavigationBar appearance] setBarTintColor: [UIColor colorWithRed: 10.0f/255.0f green: 131.0f/255.f blue: 170.0f/255.0f alpha: 1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor: [UIColor whiteColor]];
    
    NSString *sdkKey = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"AppLovinSdkKey"];
    if ( [sdkKey isEqualToString: @"YOUR_SDK_KEY"] )
    {
        [[[UIAlertView alloc] initWithTitle: @"ERROR"
                                    message: @"Please update the `AppLovinSdkKey` row in your Info.plist file with your SDK key."
                                   delegate: nil
                          cancelButtonTitle: @"OK"
                          otherButtonTitles: nil, nil] show];
    }
    
    return YES;
}

@end
