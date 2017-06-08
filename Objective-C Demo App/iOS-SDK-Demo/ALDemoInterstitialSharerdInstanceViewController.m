//
//  ALDemoInterstitialSharerdInstanceViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialSharerdInstanceViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALInterstitialAd.h"
#endif

@interface ALDemoInterstitialSharerdInstanceViewController ()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@end

@implementation ALDemoInterstitialSharerdInstanceViewController

#pragma mark - IB Action Methods

- (IBAction)showInterstitial:(id)sender
{
    if ( [ALInterstitialAd isReadyForDisplay] )
    {
        // Optional: Assign delegates.
        [ALInterstitialAd shared].adLoadDelegate = self;
        [ALInterstitialAd shared].adDisplayDelegate = self;
        [ALInterstitialAd shared].adVideoPlaybackDelegate = self; // This will only ever be used if you have video ads enabled.
        
        /*
         NOTE: We recommend the use of placements (AFTER creating them in your dashboard):
         
         [[ALInterstitialAd shared] showOverPlacement: @"SHARED_INSTANCE_SCREEN"];
         
         To learn more about placements, check out https://applovin.com/integration#iosPlacementsIntegration
         */
        [[ALInterstitialAd shared] show];
        
        [self log: @"Interstitial Shown"];
    }
    else
    {
        // Ideally, the SDK preloads ads when you initialize it in application:didFinishLaunchingWithOptions: of the app delegate
        // you can manually load an ad as demonstrated in the ALDemoInterstitialManualLoadingViewController class
        [self log: @"Interstitial not ready for display.\nPlease check SDK key or internet connection."];
    }
}

#pragma mark - Ad Load Delegate

- (void)adService:(nonnull ALAdService *)adService didLoadAd:(nonnull ALAd *)ad
{
    [self log: @"Interstitial Loaded"];
}

- (void) adService:(nonnull ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: @"Interstitial failed to load with error code = %d", code];
}

#pragma mark - Ad Display Delegate

- (void)ad:(nonnull ALAd *)ad wasDisplayedIn:(nonnull UIView *)view
{
    [self log: @"Interstitial Displayed"];
}

- (void)ad:(nonnull ALAd *)ad wasHiddenIn:(nonnull UIView *)view
{
    [self log: @"Interstitial Dismissed"];
}

- (void)ad:(nonnull ALAd *)ad wasClickedIn:(nonnull UIView *)view
{
    [self log: @"Interstitial Clicked"];
}

#pragma mark - Ad Video Playback Delegate

- (void)videoPlaybackBeganInAd:(nonnull ALAd *)ad
{
    [self log: @"Video Started"];
}

- (void)videoPlaybackEndedInAd:(nonnull ALAd *)ad atPlaybackPercent:(nonnull NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    [self log: @"Video Ended"];
}

@end
