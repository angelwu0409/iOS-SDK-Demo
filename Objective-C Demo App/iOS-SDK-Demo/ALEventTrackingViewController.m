//
//  ALEventTrackingViewController.m
//  iOS-SDK-Demo-ObjC
//
//  Created by Monica Ong on 6/5/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

#import "ALEventTrackingViewController.h"
#import <StoreKit/StoreKit.h>

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#endif

@interface ALEventTrackingViewController ()

@end

@implementation ALEventTrackingViewController
static ALEventService *eventService = nil;
//In-app Purchases
static SKPaymentTransaction *transaction = nil;
static SKProduct *product = nil;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView: tableView didSelectRowAtIndexPath: indexPath];
    
    if (!eventService){
        eventService = [ALSdk shared].eventService;
    }
    if (!transaction){
        transaction = [[SKPaymentTransaction alloc] init];
    
    }
    if (!product){
        product = [[SKProduct alloc] init];
    }
    
    switch (indexPath.row) {
        case 0:
            [self setTitle: @"User began checkout"];
            [eventService trackEvent: kALEventTypeUserBeganCheckOut
                          parameters: @{
                                        kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID",
                                        kALEventParameterRevenueAmountKey     : @"PRICE OF ITEM",
                                        kALEventParameterRevenueCurrencyKey   : @"3-LETTER CURRENCY CODE"
                                        }
             ];
            break;
        default:
            [self setTitle: @"Default event tracking initiated"];
            break;
    }
}

@end
