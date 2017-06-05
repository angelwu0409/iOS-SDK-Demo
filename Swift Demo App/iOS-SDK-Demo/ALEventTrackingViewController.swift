//
//  ALEventTrackingViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Monica on 6/5/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

import UIKit
import StoreKit
import AppLovinSDK

class ALEventTrackingViewController: ALDemoBaseTableViewController
{
    let eventService: ALEventService = (ALSdk.shared()?.eventService)!
    
    //In-App Purchases
    let transaction: SKPaymentTransaction = SKPaymentTransaction() // from paymentQueue:updatedTransactions:
    let product: SKProduct = SKProduct() // Appropriate product (matching productIdentifier property to SKPaymentTransaction)
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        switch indexPath.row {
        case 0:
            title = "User began checkout"
            eventService.trackEvent(kALEventTypeUserBeganCheckOut,
                                    parameters: [kALEventParameterProductIdentifierKey : "PRODUCT SKU OR ID",
                                                 kALEventParameterRevenueAmountKey      : "PRICE OF ITEM",
                                                 kALEventParameterRevenueCurrencyKey    :  "3-LETTER CURRENCY CODE"])
        case 1:
            title = "User added item to cart"
            eventService.trackEvent(kALEventTypeUserAddedItemToCart,
                                    parameters: [kALEventParameterProductIdentifierKey : "PRODUCT SKU OR ID"])

        case 2:
            title = "User completed achievement"
            eventService.trackEvent(kALEventTypeUserCompletedAchievement,
                                    parameters: [kALEventParameterCompletedAchievementKey : "ACHIEVEMENT NAME OR ID"])

        case 3:
            title = "User completed checkout"
            /*eventService.trackEvent(kALEventTypeUserCompletedCheckOut,
                                    parameters: [kALEventParameterCheckoutTransactionIdentifierKey : "UNIQUE TRANSACTION ID",
                                                 kALEventParameterCheckoutTransactionIdentifierKey  : "PRODUCT SKU OR ID",
                                                 kALEventParameterRevenueAmountKey                  : "AMOUNT OF MONEY SPENT",
                                                 kALEventParameterRevenueCurrencyKey                : "3-LETTER CURRENCY CODE"])*/
        case 4:
            title = "User completed level"
            eventService.trackEvent(kALEventTypeUserCompletedLevel,
                                    parameters: [kALEventParameterCompletedLevelKey : "LEVEL NAME OR NUMBER"])
        case 5:
            title = "User created reservation"
            eventService.trackEvent(kALEventTypeUserCreatedReservation,
                                    parameters: [kALEventParameterProductIdentifierKey    : "PRODUCT SKU OR ID",
                                                 kALEventParameterReservationStartDateKey  : "START NSDATE",
                                                 kALEventParameterReservationEndDateKey    : "END NSDATE"])
        case 6:
            title = "Tracking in app purchase"
            /*eventService.trackInAppPurchase(withTransactionIdentifier: transaction.transactionIdentifier!,
                                            parameters: [kALEventParameterRevenueAmountKey    : "AMOUNT OF MONEY SPENT",
                                                         kALEventParameterRevenueCurrencyKey   : "3-LETTER CURRENCY CODE",
                                                         kALEventParameterProductIdentifierKey : product.productIdentifier])*/
        case 7:
            title = "User logged in"
            eventService.trackEvent(kALEventTypeUserLoggedIn,
                                    parameters: [kALEventParameterUserAccountIdentifierKey : "USERNAME"])
        case 8:
            title = "User provided payment information"
            eventService.trackEvent(kALEventTypeUserProvidedPaymentInformation)

        case 9:
            title = "User created account"
            eventService.trackEvent(kALEventTypeUserCreatedAccount,
                                    parameters: [kALEventParameterUserAccountIdentifierKey : "USERNAME"])

        case 10:
            title = "User executed search"
            eventService.trackEvent(kALEventTypeUserExecutedSearch,
                                    parameters: [kALEventParameterSearchQueryKey : "USER'S SEARCH STRING"])
        case 11:
            title = "User sent invitation"
            eventService.trackEvent(kALEventTypeUserSentInvitation)
        case 12:
            title = "User shared link"
            eventService.trackEvent(kALEventTypeUserSharedLink)
        case 13:
            title = "User spent virtual currency"
            eventService.trackEvent(kALEventTypeUserSpentVirtualCurrency,
                                    parameters: [kALEventParameterVirtualCurrencyAmountKey : "NUMBER OF COINS SPENT",
                                                 kALEventParameterVirtualCurrencyNameKey   : "CURRENCY NAME"])
        case 14:
            title = "User completed tutorial"
            eventService.trackEvent(kALEventTypeUserCompletedTutorial)
        case 15:
            title = "User viewed content"
            eventService.trackEvent(kALEventTypeUserViewedContent,
                                    parameters: [kALEventParameterContentIdentifierKey : "SOME ID DESCRIBING CONTENT"])
        case 16:
            title = "User viewed product"
            eventService.trackEvent(kALEventTypeUserViewedProduct,
                                    parameters: [kALEventParameterProductIdentifierKey : "PRODUCT SKU OR ID"])
        case 17:
            title = "User added item to wishlist"
            eventService.trackEvent(kALEventTypeUserAddedItemToWishlist,
                                    parameters: [kALEventParameterProductIdentifierKey : "PRODUCT SKU OR ID"])
        default:
            title = "Default event tracking initiated"
        }
        
    }

}
