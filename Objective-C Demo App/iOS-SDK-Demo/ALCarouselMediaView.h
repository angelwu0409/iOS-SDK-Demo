//
//  ALCarouselMediaView.h
//  sdk
//
//  Created by Thomas So on 4/20/15.
//
//

#import <UIKit/UIKit.h>

#import "ALCarouselViewModel.h"
#import "ALCarouselRenderingProtocol.h"

@class ALCarouselCardView;

/**
 *  This view is used to store the ad's media.
 */
@interface ALCarouselMediaView : UIView <ALCarouselRenderingProtocol>


/**
 *  Initializes a newly allocated media view object with the specified sdk and parent card view.
 */
- (nonnull instancetype) initWithSdk:(nonnull ALSdk *)sdk parentView: (nonnull ALCarouselCardView*) parentView;

/**
 *  Saves the current video's states and clears it. This is for when moving a slot out of the middle card.
 */
- (void)setInactive;

-(nonnull id) init                        __attribute__((unavailable("Use initWithSdk:parentView:")));
-(nonnull id) initWithFrame:(CGRect)frame __attribute__((unavailable("Use initWithSdk:parentView:")));

@end