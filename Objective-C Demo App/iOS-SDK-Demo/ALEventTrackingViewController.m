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
        case 1:
            [self setTitle: @"User added item to cart"];
            [eventService trackEvent: kALEventTypeUserAddedItemToCart
                          parameters: @{
                                        kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID"
                                        }
             ];
            break;
        case 2:
            [self setTitle: @"User completed achievement"];
            [eventService trackEvent: kALEventTypeUserCompletedAchievement
                          parameters: @{
                                        kALEventParameterCompletedAchievementKey : @"ACHIEVEMENT NAME OR ID"
                                        }
             ];
            break;
        case 3:
            [self setTitle: @"User completed checkout"];
            [eventService trackEvent: kALEventTypeUserCompletedCheckOut
                          parameters: @{
                                        kALEventParameterCheckoutTransactionIdentifierKey : @"UNIQUE TRANSACTION ID",
                                        kALEventParameterProductIdentifierKey     : @"PRODUCT SKU OR ID",
                                        kALEventParameterRevenueAmountKey         : @"AMOUNT OF MONEY SPENT",
                                        kALEventParameterRevenueCurrencyKey       : @"3-LETTER CURRENCY CODE"
                                        }
             ];
            break;
        case 4:
            [self setTitle: @"User completed level"];
            [eventService trackEvent: kALEventTypeUserCompletedLevel
                          parameters: @{
                                        kALEventParameterCompletedLevelKey : @"LEVEL NAME OR NUMBER"
                                        }
             ];
            break;
        case 5:
            [self setTitle: @"User created reservation"];
            [eventService trackEvent: kALEventTypeUserCreatedReservation
                          parameters: @{
                                        kALEventParameterProductIdentifierKey     : @"PRODUCT SKU OR ID",
                                        kALEventParameterReservationStartDateKey  : @"START NSDATE",
                                        kALEventParameterReservationEndDateKey    : @"END NSDATE"
                                        }
             ];
            break;
        case 6:
            [self setTitle: @"Tracking in app purchase"];
            [eventService trackInAppPurchaseWithTransactionIdentifier: transaction.transactionIdentifier
                                                           parameters: @{
                                                                         kALEventParameterRevenueAmountKey : @"AMOUNT OF MONEY SPENT",
                                                                         kALEventParameterRevenueCurrencyKey : @"3-LETTER CURRENCY CODE",
                                                                         kALEventParameterProductIdentifierKey : @"product.productIdentifier"
                                                                         }
             ];
            break;
        case 7:
            [self setTitle: @"User logged in"];
            [eventService trackEvent: kALEventTypeUserLoggedIn
                          parameters: @{
                                        kALEventParameterUserAccountIdentifierKey : @"USERNAME"
                                        }
             ];
            break;
        case 8:
            [self setTitle: @"User provided payment information"];
            [eventService trackEvent: kALEventTypeUserProvidedPaymentInformation];
            break;
        case 9:
            [self setTitle: @"User created account"];
            [eventService trackEvent: kALEventTypeUserCreatedAccount
                          parameters: @{
                                        kALEventParameterUserAccountIdentifierKey : @"USERNAME"
                                        }
             ];
            break;
        case 10:
            [self setTitle: @"User executed search"];
            [eventService trackEvent: kALEventTypeUserExecutedSearch
                          parameters: @{
                                        kALEventParameterSearchQueryKey : @"USER'S SEARCH STRING"
                                        }
             ];
            break;
        case 11:
            [self setTitle: @"User sent invitation"];
            [eventService trackEvent: kALEventTypeUserSentInvitation];
            break;
        case 12:
            [self setTitle: @"User shared link"];
            [eventService trackEvent: kALEventTypeUserSharedLink];
            break;
        case 13:
            [self setTitle: @"User spent virtual currency"];
            [eventService trackEvent: kALEventTypeUserSpentVirtualCurrency
                          parameters: @{
                                        kALEventParameterVirtualCurrencyAmountKey : @"NUMBER OF COINS SPENT",
                                        kALEventParameterVirtualCurrencyNameKey : @"CURRENCY NAME"
                                        }
             ];
            break;
        case 14:
            [self setTitle: @"User completed tutorial"];
            [eventService trackEvent: kALEventTypeUserCompletedTutorial];
            break;
        case 15:
            [self setTitle: @"User viewed content"];
            [eventService trackEvent: kALEventTypeUserViewedContent
                          parameters: @{
                                        kALEventParameterContentIdentifierKey : @"SOME ID DESCRIBING CONTENT"
                                        }
             ];
            break;
        case 16:
            [self setTitle: @"User viewed product"];
            [eventService trackEvent: kALEventTypeUserViewedProduct
                          parameters: @{
                                        kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID"
                                        }
             ];
            break;
        case 17:
            [self setTitle: @"User added item to wishlist"];
            [eventService trackEvent: kALEventTypeUserAddedItemToWishlist
                          parameters: @{
                                        kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID"
                                        }
             ];
            break;
        default:
            [self setTitle: @"Default event tracking initiated"];
            break;
    }
}

@end
