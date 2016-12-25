//
//  ALDemoRSSFeedRetriever.h
//  iOS-SDK-Demo
//
//  Created by Thomas So on 11/12/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALDemoArticle.h"

@interface ALDemoRSSFeedRetriever : NSObject

typedef void(^__nonnull ALDemoRSSFeedRetrieverBlock)(NSError *__nullable error, NSArray<ALDemoArticle *> *__nonnull articles);

+ (nonnull ALDemoRSSFeedRetriever *)sharedRetriever;
- (void)startParsingWithCompletion:(ALDemoRSSFeedRetrieverBlock)completion;

@end