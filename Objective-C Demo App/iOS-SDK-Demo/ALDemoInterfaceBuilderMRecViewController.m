//
//  ALDemoInterfaceBuilderMRecViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Thomas So on 3/6/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

#import "ALDemoInterfaceBuilderMRecViewController.h"
@import AppLovinSDK;

@interface ALDemoInterfaceBuilderMRecViewController () <ALAdLoadDelegate, ALAdDisplayDelegate>
@property (nonatomic, strong) IBOutlet ALAdView *adView;
@end

@implementation ALDemoInterfaceBuilderMRecViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.adView.adLoadDelegate = self;
    self.adView.adDisplayDelegate = self;
}

#pragma mark - Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self log: @"MRec Loaded"];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    [self log: [NSString stringWithFormat: @"MRec failed to load with error code = %d", code]];
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
