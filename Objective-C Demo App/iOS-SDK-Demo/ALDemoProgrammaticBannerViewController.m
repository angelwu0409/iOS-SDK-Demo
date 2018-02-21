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

@interface ALDemoProgrammaticBannerViewController() <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdViewEventDelegate>
@property (nonatomic, strong) ALAdView *adView;
@property (nonatomic,   weak) IBOutlet UIBarButtonItem *loadButton;
@end

@implementation ALDemoProgrammaticBannerViewController
static const CGFloat kBannerHeight = 50.0f;

#pragma mark - View Lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: animated];
    
    self.adView = [[ALAdView alloc] initWithSize: [ALAdSize sizeBanner]];
    
    self.adView.adLoadDelegate = self;
    self.adView.adDisplayDelegate = self;
    self.adView.adEventDelegate = self;
    self.adView.translatesAutoresizingMaskIntoConstraints = false;
    
    [self.adView loadNextAd];
    
    [self.view addSubview: self.adView];
    
    UILayoutGuide *margins = self.view.layoutMarginsGuide;
    [NSLayoutConstraint activateConstraints: @[
                                               [self.adView.leadingAnchor constraintEqualToAnchor: margins.leadingAnchor],
                                               [self.adView.trailingAnchor constraintEqualToAnchor: margins.trailingAnchor],
                                               [self.adView.topAnchor constraintEqualToAnchor: margins.topAnchor],
                                               [self.adView.heightAnchor constraintEqualToConstant: kBannerHeight]
                                               ]];
}

#pragma mark - IB Action

- (IBAction)loadNextAd:(UIBarButtonItem *)sender
{
    [self.adView loadNextAd];
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"Banner Loaded"];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: @"Banner failed to load with error code = %d", code];
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"Banner Displayed"];
    
    self.loadButton.enabled = YES;
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"Banner Dismissed"];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"Banner Clicked"];
}

#pragma mark - Ad View Event Delegate

- (void)ad:(ALAd *)ad didPresentFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"Banner did present fullscreen"];
}

- (void)ad:(ALAd *)ad willDismissFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"Banner will dismiss fullscreen"];
}

- (void)ad:(ALAd *)ad didDismissFullscreenForAdView:(ALAdView *)adView
{
    [self log: @"Banner did dismiss fullscreen"];
}

- (void)ad:(ALAd *)ad willLeaveApplicationForAdView:(ALAdView *)adView
{
    [self log: @"Banner will leave application"];
}

- (void)ad:(ALAd *)ad didFailToDisplayInAdView:(ALAdView *)adView withError:(ALAdViewDisplayErrorCode)code
{
    [self log: @"Banner did fail to display with error code: %ld", code];
}

@end
