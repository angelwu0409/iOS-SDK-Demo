//
//  ALDemoRewardedVideosViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoRewardedVideosViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdRewardDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate
{
    @IBAction func showRewardedVideo(_ sender: AnyObject!)
    {
        // You need to preload each rewarded video before it can be displayed
        if ALIncentivizedInterstitialAd.isReadyForDisplay()
        {
            // Optional: Assign delegates
            ALIncentivizedInterstitialAd.shared().adDisplayDelegate = self
            ALIncentivizedInterstitialAd.shared().adVideoPlaybackDelegate = self
            
            ALIncentivizedInterstitialAd.showAndNotify(self)
        }
        else
        {
            self.preloadRewardedVideo(nil)
        }
    }
    
    // You need to preload each rewarded video before it can be displayed
    @IBAction func preloadRewardedVideo(_ sender: AnyObject!)
    {
        self.log("Preloading...")
        ALIncentivizedInterstitialAd.shared().preloadAndNotify(self)
    }
    
    // MARK: Ad Load Delegate
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.log("Rewarded Video Loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Rewarded video failed to load with error code \(code)")
    }
    
    // MARK: Ad Reward Delegate
    
    func rewardValidationRequest(for ad: ALAd, didSucceedWithResponse response: [AnyHashable: Any])
    {
        /* AppLovin servers validated the reward. Refresh user balance from your server.  We will also pass the number of coins
        awarded and the name of the currency.  However, ideally, you should verify this with your server before granting it. */
        
        // i.e. - "Coins", "Gold", whatever you set in the dashboard.
        let currencyName = response["currency"]
        
        // For example, "5" or "5.00" if you've specified an amount in the UI.
        let amountGivenString = response["amount"]
        if let amount = amountGivenString as? NSString
        {
            let amountGiven = amount.floatValue
            
            // Do something with this information.
            // MYCurrencyManagerClass.updateUserCurrency(currencyName withChange: amountGiven)
            self.log("Rewarded \(amountGiven) \(String(describing: currencyName))")
        }
 
        // By default we'll show a UIAlertView informing your user of the currency & amount earned.
        // If you don't want this, you can turn it off in the Manage Apps UI.
    }
    
    func rewardValidationRequest(for ad: ALAd, didFailWithError responseCode: Int)
    {
        if responseCode == Int(kALErrorCodeIncentivizedUserClosedVideo)
        {
            // Your user exited the video prematurely. It's up to you if you'd still like to grant
            // a reward in this case. Most developers choose not to. Note that this case can occur
            // after a reward was initially granted (since reward validation happens as soon as a
            // video is launched).
        }
        else if responseCode == Int(kALErrorCodeIncentivizedValidationNetworkTimeout) || responseCode == Int(kALErrorCodeIncentivizedUnknownServerError)
        {
            // Some server issue happened here. Don't grant a reward. By default we'll show the user
            // a UIAlertView telling them to try again later, but you can change this in the
            // Manage Apps UI.
        }
        else if responseCode == Int(kALErrorCodeIncentiviziedAdNotPreloaded)
        {
            // Indicates that you called for a rewarded video before one was available.
        }
        
        self.log("Reward validation request failed with error code \(responseCode)")
    }
    
    func rewardValidationRequest(for ad: ALAd, didExceedQuotaWithResponse response: [AnyHashable: Any])
    {
        // Your user has already earned the max amount you allowed for the day at this point, so
        // don't give them any more money. By default we'll show them a UIAlertView explaining this,
        // though you can change that from the Manage Apps UI.
        self.log("Reward validation request did exceed quota with response: \(response)")
    }
    
    func rewardValidationRequest(for ad: ALAd, wasRejectedWithResponse response: [AnyHashable: Any])
    {
        // Your user couldn't be granted a reward for this view. This could happen if you've blacklisted
        // them, for example. Don't grant them any currency. By default we'll show them a UIAlertView explaining this,
        // though you can change that from the Manage Apps UI.
        self.log("Reward validation request was rejected with response: \(response)")
    }
    
    func userDeclined(toViewAd ad: ALAd)
    {
        self.log("User declined to view ad")
    }
    
    // MARK: Ad Display Delegate
    
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("Ad Displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("Ad Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("Ad Clicked")
    }
    
    // MARK: Ad Video Playback Delegate
    
    func videoPlaybackBegan(in ad: ALAd)
    {
        self.log("Video Started")
    }
    
    func videoPlaybackEnded(in ad: ALAd, atPlaybackPercent percentPlayed: NSNumber, fullyWatched wasFullyWatched: Bool)
    {
        self.log("Video Ended")
    }
}
