//
//  ALDemoProgrammaticBannerViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Thomas So on 3/5/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

#import "ALDemoProgrammaticBannerViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALAdView.h"
#endif

@interface ALDemoProgrammaticBannerViewController() <ALAdLoadDelegate, ALAdDisplayDelegate>
@end

@implementation ALDemoProgrammaticBannerViewController
static const CGFloat kBannerHeight = 50.0f;

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    ALAdView *adView = [[ALAdView alloc] initWithFrame: CGRectMake(0.0f, CGRectGetHeight(self.view.bounds) - kBannerHeight, CGRectGetWidth(self.view.bounds), kBannerHeight)
                                                  size: [ALAdSize sizeBanner]
                                                   sdk: [ALSdk shared]];
    adView.adLoadDelegate = self;
    adView.adDisplayDelegate = self;
    
    [adView loadNextAd];
    
    [self.view addSubview: adView];
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"Banner Loaded"];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: [NSString stringWithFormat: @"Banner failed to load with error code = %d", code]];
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"Banner Displayed"];
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"Banner Dismissed"];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"Banner Clicked"];
}

@end
