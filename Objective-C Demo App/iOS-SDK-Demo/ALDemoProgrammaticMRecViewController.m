//
//  ALDemoProgrammaticMRecViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Thomas So on 3/6/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

#import "ALDemoProgrammaticMRecViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALAdView.h"
#endif

@interface ALDemoProgrammaticMRecViewController () <ALAdLoadDelegate, ALAdDisplayDelegate>

@end

@implementation ALDemoProgrammaticMRecViewController
static const CGFloat kMRecHeight = 250.0f;
static const CGFloat kMRecWidth = 300.0f;

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    ALAdView *adView = [[ALAdView alloc] initWithFrame: CGRectMake(CGRectGetMidX(self.view.bounds) - kMRecWidth/2.0f, 80.0f, kMRecWidth, kMRecHeight)
                                                  size: [ALAdSize sizeMRec]
                                                   sdk: [ALSdk shared]];
    
    adView.adLoadDelegate = self;
    adView.adDisplayDelegate = self;
    
    [adView loadNextAd];
    
    [self.view addSubview: adView];
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"MRec Loaded"];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: @"MRec failed to load with error code = %d", code];
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"MRec Displayed"];
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"MRec Dismissed"];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"MRec Clicked"];
}

@end
