//
//  ALDemoArticle.h
//  iOS-SDK-Demo
//
//  Created by Thomas So on 11/12/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDemoArticle : NSObject

@property (nonatomic,   copy, nonnull) NSString *title;
@property (nonatomic,   copy, nonnull) NSString *pubDate;
@property (nonatomic,   copy, nonnull) NSString *creator;
@property (nonatomic,   copy, nonnull) NSString *articleDescription;
@property (nonatomic, strong, nonnull) NSURL    *link;

@property (nonatomic, assign) BOOL isAd;

@end
