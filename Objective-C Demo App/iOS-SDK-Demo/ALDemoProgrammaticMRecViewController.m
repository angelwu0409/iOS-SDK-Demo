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

@interface ALDemoProgrammaticMRecViewController () <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdViewEventDelegate>
@end

@implementation ALDemoProgrammaticMRecViewController
static const CGFloat kMRecHeight = 250.0f;
static const CGFloat kMRecWidth = 300.0f;

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    // Create the MRec view
    ALAdView *adView = [[ALAdView alloc] initWithSize: [ALAdSize sizeMRec]];
    
    // Optional: Implement the ad delegates to receive ad events.
    adView.adLoadDelegate = self;
    adView.adDisplayDelegate = self;
    adView.adEventDelegate = self;
    adView.translatesAutoresizingMaskIntoConstraints = false;
    
    // Call loadNextAd() to start showing ads
    [adView loadNextAd];
    
    [self.view addSubview: adView];
    
    // Center the MRec.
    [self.view addConstraints: @[
                                 [NSLayoutConstraint constraintWithItem: adView attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterX multiplier: 1.0 constant: 0.0],
                                 [NSLayoutConstraint constraintWithItem: adView attribute: NSLayoutAttributeCenterY relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeCenterY multiplier: 1.0 constant: 0.0],
                                 [NSLayoutConstraint constraintWithItem: adView attribute: NSLayoutAttributeHeight relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: kMRecHeight],
                                 [NSLayoutConstraint constraintWithItem: adView attribute: NSLayoutAttributeWidth relatedBy: NSLayoutRelationEqual toItem: nil attribute: NSLayoutAttributeNotAnAttribute multiplier: 1.0 constant: kMRecWidth]
                                 ]];
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

#pragma mark - Ad View Event Delegate

- (void)ad:(ALAd *)ad didPresentFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"MRec did present fullscreen"];
}

- (void)ad:(ALAd *)ad willDismissFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"MRec Will dismiss fullscreen"];
}

- (void)ad:(ALAd *)ad didDismissFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"MRec did dismiss fullscreen"];
}

- (void)ad:(ALAd *)ad willLeaveApplicationForAdView:(ALAdView *)adView
{
    [self log: @"MRec will leave application"];
}

- (void)ad:(ALAd *)ad didFailToDisplayInAdView:(ALAdView *)adView withError:(ALAdViewDisplayErrorCode)code
{
    [self log: @"MRec did fail to display with error code: %ld", code];
}

@end
