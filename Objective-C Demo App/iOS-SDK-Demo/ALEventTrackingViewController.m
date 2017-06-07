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
#else
    #import "ALSdk.h"
    #import "ALEventService.h"
#endif

@interface ALDemoEvent : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *purpose;

- (instancetype)initWithName:(NSString *)name purpose:(NSString *)purpose;

@end

@interface ALEventTrackingViewController()
@property (nonatomic, strong) NSArray<ALDemoEvent *> *events;
@end

@implementation ALEventTrackingViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.events = @[
                    [[ALDemoEvent alloc] initWithName: @"Began Checkout Event" purpose: @"Track when user begins checkout procedure"],
                    [[ALDemoEvent alloc] initWithName: @"Cart Event" purpose: @"Track when user adds an item to cart"],
                    [[ALDemoEvent alloc] initWithName: @"Completed Achievement Event" purpose: @"Track when user completed an achievement"],
                    [[ALDemoEvent alloc] initWithName: @"Completed Checkout Event" purpose: @"Track when user completed checkout"],
                    [[ALDemoEvent alloc] initWithName: @"Completed Level Event" purpose: @"Track when user completed level"],
                    [[ALDemoEvent alloc] initWithName: @"Created Reservation Event" purpose: @"Track when user created a reservation"],
                    [[ALDemoEvent alloc] initWithName: @"In-App Purchase Event" purpose: @"Track when user makes an in-app purchase"],
                    [[ALDemoEvent alloc] initWithName: @"Login Event" purpose: @"Track when user logs in"],
                    [[ALDemoEvent alloc] initWithName: @"Payment Info Event" purpose: @"Tracks when user inputs their payment information"],
                    [[ALDemoEvent alloc] initWithName: @"Registration Event" purpose: @"Track when user registers"],
                    [[ALDemoEvent alloc] initWithName: @"Search Event" purpose: @"Track when user makes a search"],
                    [[ALDemoEvent alloc] initWithName: @"Sent Invitation Event" purpose: @"Track when user sends invitation"],
                    [[ALDemoEvent alloc] initWithName: @"Shared Link Event" purpose: @"Track when user shares a link"],
                    [[ALDemoEvent alloc] initWithName: @"Spent Virtual Currency Event" purpose: @"Track when users spends virtual currency"],
                    [[ALDemoEvent alloc] initWithName: @"Tutorial Event" purpose: @"Track when users does a tutorial"],
                    [[ALDemoEvent alloc] initWithName: @"Viewed Content Event" purpose: @"Track when user views content"],
                    [[ALDemoEvent alloc] initWithName: @"Viewed Product Event" purpose: @"Track when user views product"],
                    [[ALDemoEvent alloc] initWithName: @"Wishlist Event" purpose: @"Track when user adds an item to their wishlist"]
                    ];
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const kCellIdentifier = @"rootPrototype";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
    if ( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: kCellIdentifier];
    }
    
    cell.textLabel.text = self.events[indexPath.row].name;
    cell.detailTextLabel.text = self.events[indexPath.row].purpose;
    
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView: tableView didSelectRowAtIndexPath: indexPath];
    
    ALEventService *eventService = [ALSdk shared].eventService;
    
    ALDemoEvent *event = self.events[indexPath.row];
    [self setTitle: event.name];
    
    switch ( indexPath.row )
    {
        case 0:
        {
            [eventService trackEvent: kALEventTypeUserBeganCheckOut
                          parameters: @{kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID",
                                        kALEventParameterRevenueAmountKey     : @"PRICE OF ITEM",
                                        kALEventParameterRevenueCurrencyKey   : @"3-LETTER CURRENCY CODE"}];
            break;
        }
        case 1: {
            
            [eventService trackEvent: kALEventTypeUserAddedItemToCart
                          parameters: @{kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID"}];
            break;
        }
        case 2:
        {
            [eventService trackEvent: kALEventTypeUserCompletedAchievement
                          parameters: @{kALEventParameterCompletedAchievementKey : @"ACHIEVEMENT NAME OR ID"}];
            break;
        }
        case 3: {
            [eventService trackEvent: kALEventTypeUserCompletedCheckOut
                          parameters: @{kALEventParameterCheckoutTransactionIdentifierKey : @"UNIQUE TRANSACTION ID",
                                        kALEventParameterProductIdentifierKey             : @"PRODUCT SKU OR ID",
                                        kALEventParameterRevenueAmountKey                 : @"AMOUNT OF MONEY SPENT",
                                        kALEventParameterRevenueCurrencyKey               : @"3-LETTER CURRENCY CODE"}];
            break;
        }
        case 4: {
            [eventService trackEvent: kALEventTypeUserCompletedLevel
                          parameters: @{kALEventParameterCompletedLevelKey : @"LEVEL NAME OR NUMBER"}];
            break;
        }
        case 5: {
            [eventService trackEvent: kALEventTypeUserCreatedReservation
                          parameters: @{kALEventParameterProductIdentifierKey    : @"PRODUCT SKU OR ID",
                                        kALEventParameterReservationStartDateKey : @"START NSDATE",
                                        kALEventParameterReservationEndDateKey   : @"END NSDATE"}];
            break;
        }
        case 6: {
            SKPaymentTransaction *transaction = [[SKPaymentTransaction alloc] init]; // from paymentQueue:updatedTransactions:
            //SKProduct* product = ...; // Appropriate product (matching productIdentifier property to SKPaymentTransaction);
            [eventService trackInAppPurchaseWithTransactionIdentifier: transaction.transactionIdentifier
                                                           parameters: @{kALEventParameterRevenueAmountKey : @"AMOUNT OF MONEY SPENT",
                                                                         kALEventParameterRevenueCurrencyKey : @"3-LETTER CURRENCY CODE",
                                                                         kALEventParameterProductIdentifierKey : @"product.productIdentifier"}]; //product.productIdentifier
            break;
        }
        case 7: {
            [eventService trackEvent: kALEventTypeUserLoggedIn
                          parameters: @{kALEventParameterUserAccountIdentifierKey : @"USERNAME"}];
            break;
        }
        case 8: {
            [eventService trackEvent: kALEventTypeUserProvidedPaymentInformation];
            break;
        }
        case 9: {
            [eventService trackEvent: kALEventTypeUserCreatedAccount
                          parameters: @{kALEventParameterUserAccountIdentifierKey : @"USERNAME"}];
            break;
        }
        case 10: {
            [eventService trackEvent: kALEventTypeUserExecutedSearch
                          parameters: @{kALEventParameterSearchQueryKey : @"USER'S SEARCH STRING"}];
            break;
        }
        case 11: {
            [eventService trackEvent: kALEventTypeUserSentInvitation];
            break;
        }
        case 12: {
            [eventService trackEvent: kALEventTypeUserSharedLink];
            break;
        }
        case 13: {
            [eventService trackEvent: kALEventTypeUserSpentVirtualCurrency
                          parameters: @{kALEventParameterVirtualCurrencyAmountKey : @"NUMBER OF COINS SPENT",
                                        kALEventParameterVirtualCurrencyNameKey : @"CURRENCY NAME"}];
            
            break;
        }
        case 14: {
            [eventService trackEvent: kALEventTypeUserCompletedTutorial];
            break;
        }
        case 15: {
            [eventService trackEvent: kALEventTypeUserViewedContent
                          parameters: @{kALEventParameterContentIdentifierKey : @"SOME ID DESCRIBING CONTENT"}];
            break;
        }
        case 16: {
            [eventService trackEvent: kALEventTypeUserViewedProduct
                          parameters: @{kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID"}];
            break;
        }
        case 17: {
            [eventService trackEvent: kALEventTypeUserAddedItemToWishlist
                          parameters: @{kALEventParameterProductIdentifierKey : @"PRODUCT SKU OR ID"}];
            break;
        }
        default: {
            [self setTitle: @"Default event tracking initiated"];
            break;
        }
    }
}

@end

@implementation ALDemoEvent

- (instancetype)initWithName:(NSString *)name purpose:(NSString *)purpose
{
    self = [super init];
    if ( self )
    {
        self.name = name;
        self.purpose = purpose;
    }
    return self;
}

@end
