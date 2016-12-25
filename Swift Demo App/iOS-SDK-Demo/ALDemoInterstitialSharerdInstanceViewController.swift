//
//  ALDemoInterstitialSharerdInstanceViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoInterstitialSharerdInstanceViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate
{
    @IBAction func showInterstitial(_ sender: AnyObject!)
    {
        if ALInterstitialAd.isReadyForDisplay()
        {
            // Optional: Assign delegates.
            ALInterstitialAd.shared().adLoadDelegate = self;
            ALInterstitialAd.shared().adDisplayDelegate = self;
            ALInterstitialAd.shared().adVideoPlaybackDelegate = self; // This will only ever be used if you have video ads enabled.
            
            /*
             NOTE: We recommend the use of placements (AFTER creating them in your dashboard):
             
             ALInterstitialAd.shared().showOverPlacement("SHARED_INSTANCE_SCREEN")
             
             To learn more about placements, check out https://applovin.com/integration#iosPlacementsIntegration
             */
            
            ALInterstitialAd.shared().show()
            self.log("Interstitial Shown")
        }
        else
        {
            // Ideally, the SDK preloads ads when you initialize it in application:didFinishLaunchingWithOptions: of the app delegate
            // you can manually load an ad as demonstrated in the ALDemoInterstitialManualLoadingViewController class
            self.log("Interstitial not ready for display.\nPlease check SDK key or internet connection.")
        }
    }
    
    // MARK: Ad Load Delegate
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.log("Interstitial Loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Interstitial failed to load with error code \(code)")
    }
    
    // MARK: Ad Display Delegate
    
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("Interstitial Displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("Interstitial Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("Interstitial Clicked")
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
