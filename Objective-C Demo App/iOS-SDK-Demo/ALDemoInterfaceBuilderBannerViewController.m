//
//  ALDemoInterfaceBuilderBannerViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Thomas So on 3/6/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

#import "ALDemoInterfaceBuilderBannerViewController.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALAdService.h"
    #import "ALAdView.h"
#endif

@interface ALDemoInterfaceBuilderBannerViewController () <ALAdLoadDelegate, ALAdDisplayDelegate>
@property (weak, nonatomic) IBOutlet ALAdView *adView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *loadButton;
@end

@implementation ALDemoInterfaceBuilderBannerViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.adView.adLoadDelegate = self;
    self.adView.adDisplayDelegate = self;
}

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
    [self log: [NSString stringWithFormat: @"Banner failed to load with error code = %d", code]];
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

@end
