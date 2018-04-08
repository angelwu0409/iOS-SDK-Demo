//
//  ALCarouselModel.h
//  sdk
//
//  Created by Matt Szaro on 4/20/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ALNativeAd;
@class ALCarouselCardState;
@class ALSdk;

@interface ALCarouselViewModel : NSObject

@property (strong, nonatomic, readonly) NSArray* __nullable nativeAds;
@property (assign, nonatomic, readonly) NSUInteger nativeAdsCount;

-(nonnull instancetype) initWithNativeAds: (nonnull NSArray *)ads;
-(nullable ALCarouselCardState*) cardStateForNativeAd: (nonnull ALNativeAd*) ad;
-(nullable ALCarouselCardState*) cardStateAtNativeAdIndex: (NSUInteger) index;
-(nullable ALNativeAd*) nativeAdAtIndex: (NSUInteger) index;

-(void) removeAllObjects;

@end