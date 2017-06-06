//
//  ALEventTrackingViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Monica Ong on 6/5/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

import UIKit
import StoreKit
import AppLovinSDK

struct ALDemoEvent
{
    var name: String
    var purpose: String
}

class ALEventTrackingViewController: ALDemoBaseTableViewController
{
    var events: [ALDemoEvent] = []
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        events = [ALDemoEvent(name: "Began Checkout Event", purpose: "Track when user begins checkout procedure"),
                  ALDemoEvent(name: "Cart Event", purpose: "Track when user adds an item to cart"),
                  ALDemoEvent(name: "Completed Achievement Event", purpose: "Track when user completed an achievement"),
                  ALDemoEvent(name: "Completed Checkout Event", purpose: "Track when user completed checkout"),
                  ALDemoEvent(name: "Completed Level Event", purpose: "Track when user completed level"),
                  ALDemoEvent(name: "Created Reservation Event", purpose: "Track when user created a reservation"),
                  ALDemoEvent(name: "In-App Purchase Event", purpose: "Track when user makes an in-app purchase"),
                  ALDemoEvent(name: "Login Event", purpose: "Track when user logs in"),
                  ALDemoEvent(name: "Payment Info Event", purpose: "Tracks when user inputs their payment information"),
                  ALDemoEvent(name: "Registration Event", purpose: "Track when user registers"),
                  ALDemoEvent(name: "Search Event", purpose: "Track when user makes a search"),
                  ALDemoEvent(name: "Sent Invitation Event", purpose: "Track when user sends invitation"),
                  ALDemoEvent(name: "Shared Link Event", purpose: "Track when user shares a link"),
                  ALDemoEvent(name: "Spent Virtual Currency Event", purpose: "Track when users spends virtual currency"),
                  ALDemoEvent(name: "Tutorial Event", purpose: "Track when users does a tutorial"),
                  ALDemoEvent(name: "Viewed Content Event", purpose: "Track when user views content"),
                  ALDemoEvent(name: "Viewed Product Event", purpose: "Track when user views product"),
                  ALDemoEvent(name: "Wishlist Event", purpose: "Track when user adds an item to their wishlist")
                 ]
    }
    
    // MARK: Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "rootPrototype", for: indexPath)
        
        cell.textLabel?.text = events[indexPath.row].name
        cell.detailTextLabel?.text = events[indexPath.row].purpose
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        guard let eventService: ALEventService = ALSdk.shared()?.eventService else {
            title = "Unable to track events because eventService is nil"
            return
        }

        switch indexPath.row {
        case 0:
            title = "User began checkout"
            eventService.trackEvent(kALEventTypeUserBeganCheckOut,
                                    parameters: [kALEventParameterProductIdentifierKey : "PRODUCT SKU OR ID",
                                                 kALEventParameterRevenueAmountKey     : "PRICE OF ITEM",
                                                 kALEventParameterRevenueCurrencyKey   : "3-LETTER CURRENCY CODE"])
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
            eventService.trackEvent(kALEventTypeUserCompletedCheckOut,
                                    parameters: [kALEventParameterCheckoutTransactionIdentifierKey : "UNIQUE TRANSACTION ID",
                                                 kALEventParameterProductIdentifierKey             : "PRODUCT SKU OR ID",
                                                 kALEventParameterRevenueAmountKey                 : "AMOUNT OF MONEY SPENT",
                                                 kALEventParameterRevenueCurrencyKey               : "3-LETTER CURRENCY CODE"])
        case 4:
            title = "User completed level"
            eventService.trackEvent(kALEventTypeUserCompletedLevel,
                                    parameters: [kALEventParameterCompletedLevelKey : "LEVEL NAME OR NUMBER"])
        case 5:
            title = "User created reservation"
            eventService.trackEvent(kALEventTypeUserCreatedReservation,
                                    parameters: [kALEventParameterProductIdentifierKey    : "PRODUCT SKU OR ID",
                                                 kALEventParameterReservationStartDateKey : "START NSDATE",
                                                 kALEventParameterReservationEndDateKey   : "END NSDATE"])
        case 6:
            title = "Tracking in app purchase"
            //In-App Purchases
            // let transaction: SKPaymentTransaction = ... // from paymentQueue:updatedTransactions:
            //let product: SKProduct = ... // Appropriate product (matching productIdentifier property to SKPaymentTransaction)
            eventService.trackInAppPurchase(withTransactionIdentifier: "transaction.transactionIdentifier",
                                            parameters: [kALEventParameterRevenueAmountKey     : "AMOUNT OF MONEY SPENT",
                                                         kALEventParameterRevenueCurrencyKey   : "3-LETTER CURRENCY CODE",
                                                         kALEventParameterProductIdentifierKey : "product.productIdentifier"]) //product.productIdentifier
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
