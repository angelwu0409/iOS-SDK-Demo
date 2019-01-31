//
//  ALDemoRewardedVideosZoneViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Suyash Saxena on 6/19/18.
//  Copyright © 2018 AppLovin. All rights reserved.
//

#import "ALDemoRewardedVideosZoneViewController.h"
#import <AppLovinSDK/AppLovinSDK.h>

@interface ALDemoRewardedVideosZoneViewController ()<ALAdLoadDelegate, ALAdRewardDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
@property (nonatomic, strong) ALIncentivizedInterstitialAd *incentivizedInterstitial;
@end

@implementation ALDemoRewardedVideosZoneViewController

//
// IMPORTANT: Before integrating Rewarded Video into your application, please be sure it is turned 'ON' in the Manage Apps section.
//

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set an optional user identifier used for S2S callbacks
    [ALIncentivizedInterstitialAd setUserIdentifier: @"DEMO_USER_IDENTIFIER"];
    
    self.incentivizedInterstitial = [[ALIncentivizedInterstitialAd alloc] initWithZoneIdentifier: @"YOUR_ZONE_ID"];
}

#pragma mark - IB Action Methods

- (IBAction)showRewardedVideo:(id)sender
{
    // You need to preload each rewarded video before it can be displayed
    if ( self.incentivizedInterstitial.isReadyForDisplay )
    {
        // Optional: Assign delegates
        self.incentivizedInterstitial.adDisplayDelegate = self;
        self.incentivizedInterstitial.adVideoPlaybackDelegate = self;
        
        [self.incentivizedInterstitial showAndNotify: self];
    }
    else
    {
        [self preloadRewardedVideo: nil];
    }
}

// You need to preload each rewarded video before it can be displayed
- (IBAction)preloadRewardedVideo:(id)sender
{
    [self log: @"Preloading..."];
    
    [self.incentivizedInterstitial preloadAndNotify: self];
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"Rewarded video loaded"];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    [self log: @"Rewarded video failed to load with error code %d", code];
}

#pragma mark - Ad Reward Delegate

- (void)rewardValidationRequestForAd:(ALAd *)ad didSucceedWithResponse:(NSDictionary *)response
{
    /* AppLovin servers validated the reward. Refresh user balance from your server.  We will also pass the number of coins
     awarded and the name of the currency.  However, ideally, you should verify this with your server before granting it. */
    
    // i.e. - "Coins", "Gold", whatever you set in the dashboard.
    NSString *currencyName = response[@"currency"];
    
    // For example, "5" or "5.00" if you've specified an amount in the UI.
    NSString *amountGivenString = response[@"amount"];
    NSNumber *amountGiven = @([amountGivenString floatValue]);
    
    // Do something with this information.
    // [MYCurrencyManagerClass updateUserCurrency: currencyName withChange: amountGiven];
    [self log: @"Rewarded %@ %@", amountGiven, currencyName];
    
    // By default we'll show a UIAlertView informing your user of the currency & amount earned.
    // If you don't want this, you can turn it off in the Manage Apps UI.
}

- (void)rewardValidationRequestForAd:(ALAd *)ad didFailWithError:(NSInteger)responseCode
{
    if (responseCode == kALErrorCodeIncentivizedUserClosedVideo)
    {
        // Your user exited the video prematurely. It's up to you if you'd still like to grant
        // a reward in this case. Most developers choose not to. Note that this case can occur
        // after a reward was initially granted (since reward validation happens as soon as a
        // video is launched).
    }
    else if (responseCode == kALErrorCodeIncentivizedValidationNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError)
    {
        // Some server issue happened here. Don't grant a reward. By default we'll show the user
        // a UIAlertView telling them to try again later, but you can change this in the
        // Manage Apps UI.
    }
    else if (responseCode == kALErrorCodeIncentiviziedAdNotPreloaded)
    {
        // Indicates that the developer called for a rewarded video before one was available.
    }
    
    [self log: @"Reward validation request for ad failed with error code: %ld", responseCode];
}

- (void)rewardValidationRequestForAd:(ALAd *)ad didExceedQuotaWithResponse:(NSDictionary *)response
{
    // Your user has already earned the max amount you allowed for the day at this point, so
    // don't give them any more money. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
    [self log: @"Reward validation request for ad did exceed quota with response: %@", response];
}

- (void)rewardValidationRequestForAd:(ALAd *)ad wasRejectedWithResponse:(NSDictionary *)response
{
    // Your user couldn't be granted a reward for this view. This could happen if you've blacklisted
    // them, for example. Don't grant them any currency. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
    [self log: @"Reward validation request was rejected with response: %@", response];
}

- (void)userDeclinedToViewAd:(ALAd *)ad
{
    [self log: @"User declined to view ad"];
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"Ad Displayed"];
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"Ad Dismissed"];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"Ad Clicked"];
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
