//
//  ALCarouselView.h
//
//  Created by Thomas So on 3/30/15.
//  Copyright (c) 2015, AppLovin Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALSdk.h"
    #import "ALNativeAdLoadDelegate.h"
#endif

/**
 *  This class is used to display native ads to the user.
 */
@interface ALCarouselView : UIView

/**
 *  An object conforming to the ALNativeAdGroupLoadDelegate protocol, which, if set, will be notified of ad load events.
 */
@property (weak, nonatomic) id<ALNativeAdLoadDelegate> __nullable loadDelegate;

/**
 *  The current native ad(s) being displayed.
 */
@property (strong, nonatomic, readonly) NSArray* __nullable nativeAds;

/**
 *  Initializes a newly allocated carousel view object with the specified frame rectangle.
 */
-(nonnull instancetype) initWithFrame: (CGRect) frame;

/**
 *  Initializes a newly allocated carousel view object with the specified frame rectangle and sdk.
 */
-(nonnull instancetype) initWithFrame: (CGRect) frame sdk: (nonnull ALSdk *)sdk;

/**
 *  Initializes a newly allocated carousel view object with the specified frame rectangle, sdk, and native ad(s) to display.
 */
-(nonnull instancetype) initWithFrame: (CGRect) frame sdk: (nonnull ALSdk *)sdk nativeAds: (nullable NSArray*) nativeAds;


-(nonnull id) init __attribute__((unavailable("Use initWithFrame: or initWithFrame:sdk: or initWithFrame:sdk:nativeAds:")));

@end
