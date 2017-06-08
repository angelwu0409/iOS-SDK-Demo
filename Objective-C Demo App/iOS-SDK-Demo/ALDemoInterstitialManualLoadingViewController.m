//
//  ALDemoInterstitialManualLoadingViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialManualLoadingViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALInterstitialAd.h"
#endif

@interface ALDemoInterstitialManualLoadingViewController()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@property (nonatomic, strong) ALAd *ad;
@end

@implementation ALDemoInterstitialManualLoadingViewController

- (IBAction)loadInterstitial:(id)sender
{
    [self log: @"Interstitial loading..."];
    [[ALSdk shared].adService loadNextAd: [ALAdSize sizeInterstitial] andNotify: self];
}

- (IBAction)showInterstitial:(id)sender
{
    // Optional: Assign delegates
    [ALInterstitialAd shared].adDisplayDelegate = self;
    [ALInterstitialAd shared].adVideoPlaybackDelegate = self;
    
    /*
     NOTE: We recommend the use of placements (AFTER creating them in your dashboard):
     
     [[ALInterstitialAd shared] showOver: [UIApplication sharedApplication].keyWindow placement: @"MANUAL_LOADING_SCREEN" andRender: self.ad];
     
     To learn more about placements, check out https://applovin.com/integration#iosPlacementsIntegration
     */
    
    [[ALInterstitialAd shared] showOver: [UIApplication sharedApplication].keyWindow andRender: self.ad];
    
    [self log: @"Interstitial Shown"];
}

#pragma mark - Ad Load Delegate

- (void)adService:(nonnull ALAdService *)adService didLoadAd:(nonnull ALAd *)ad
{
    [self log: @"Interstitial ad Loaded"];
    
    self.ad = ad;
    self.showButton.enabled = YES;
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
