//
//  ALDemoInterstitialBasicIntegrationViewController.m
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/23/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import "ALDemoInterstitialBasicIntegrationViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALInterstitialAd.h"
#endif

@interface ALDemoInterstitialBasicIntegrationViewController ()<ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@property (nonatomic, strong) ALInterstitialAd *interstitial;
@end

@implementation ALDemoInterstitialBasicIntegrationViewController

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // If creating an instance of `ALInterstitialAd`, you must store it in a @property so it doesn't get dealloc'd by ARC
    // Alternatively, you can use `[ALInterstitialAd sharedInstance]`
    self.interstitial = [[ALInterstitialAd alloc] initWithSdk: [ALSdk shared]];
    self.interstitial.adLoadDelegate = self;
    self.interstitial.adDisplayDelegate = self;
    self.interstitial.adVideoPlaybackDelegate = self;
}

#pragma mark - IB Action Methods

- (IBAction)showInterstitial:(id)sender
{
    if ( [self.interstitial isReadyForDisplay] )
    {
        [self.interstitial show];
        [self log: @"Interstitial Shown"];
    }
    else
    {
        [self log: @"Interstitial not ready for display.\nPlease check SDK key or internet connection."];
    }
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"Interstitial Loaded"];
}

- (void) adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: @"Interstitial failed to load with error code = %d", code];
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"Interstitial Displayed"];
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"Interstitial Dismissed"];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"Interstitial Clicked"];
}

#pragma mark - Ad Video Playback Delegate

- (void)videoPlaybackBeganInAd:(ALAd *)ad
{
    [self log: @"Video Started"];
}

- (void)videoPlaybackEndedInAd:(ALAd *)ad atPlaybackPercent:(NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    [self log: @"Video Ended"];
}

@end
