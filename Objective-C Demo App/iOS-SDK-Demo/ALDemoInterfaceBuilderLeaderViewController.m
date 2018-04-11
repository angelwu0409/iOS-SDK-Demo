//
//  ALDemoInterfaceBuilderLeaderViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Santosh Bagadi on 4/4/18.
//  Copyright © 2018 AppLovin. All rights reserved.
//

#import "ALDemoInterfaceBuilderLeaderViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
#import <AppLovinSDK/AppLovinSDK.h>
#else
#import "ALAdView.h"
#endif

@interface ALDemoInterfaceBuilderLeaderViewController () <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdViewEventDelegate>
@property (weak, nonatomic) IBOutlet ALAdView *adView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;
@end

@implementation ALDemoInterfaceBuilderLeaderViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.adView.adLoadDelegate = self;
    self.adView.adDisplayDelegate = self;
    self.adView.adEventDelegate = self;
}

#pragma mark - IB Action

- (IBAction)loadNextAd:(UIBarButtonItem *)sender
{
    [self.adView loadNextAd];

    sender.enabled = NO;
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"Leader Loaded"];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: @"Leader failed to load with error code = %d", code];

    self.loadButton.enabled = YES;
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"Leader Displayed"];

    self.loadButton.enabled = YES;
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"Leader Dismissed"];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"Leader Clicked"];
}

#pragma mark - Ad View Event Delegate

- (void)ad:(ALAd *)ad didPresentFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"Leader did present fullscreen"];
}

- (void)ad:(ALAd *)ad willDismissFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"Leader Will dismiss fullscreen"];
}

- (void)ad:(ALAd *)ad didDismissFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"Leader did dismiss fullscreen"];
}

- (void)ad:(ALAd *)ad willLeaveApplicationForAdView:(ALAdView *)adView
{
    [self log: @"Leader will leave application"];
}

- (void)ad:(ALAd *)ad didFailToDisplayInAdView:(ALAdView *)adView withError:(ALAdViewDisplayErrorCode)code
{
    [self log: @"Leader did fail to display with error code: %ld", code];
}

@end
