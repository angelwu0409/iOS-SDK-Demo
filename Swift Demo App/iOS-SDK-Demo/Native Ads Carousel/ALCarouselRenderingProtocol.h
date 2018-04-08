//
//  ALCarouselRenderingProtocol.h
//  sdk
//
//  Created by Matt Szaro on 5/7/15.
//
//

@import AppLovinSDK;
#import <Foundation/Foundation.h>
#import "ALCarouselCardState.h"

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
