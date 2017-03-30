//
//  ALCarouselRenderingProtocol.h
//  sdk
//
//  Created by Matt Szaro on 5/7/15.
//
//

#import <Foundation/Foundation.h>
#import "ALCarouselCardState.h"

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALNativeAd.h"
#endif

@protocol ALCarouselRenderingProtocol <NSObject>

@optional
- (void)renderViewForNativeAd:(nonnull ALNativeAd *)ad;

@required
- (void)renderViewForNativeAd:(nonnull ALNativeAd *)ad cardState:(nonnull ALCarouselCardState *)cardState;

/**
 *  Resets the current card's view properties.
 */
- (void)clearView;

@end
