//
//  ALDemoInterstitialSingleInstanceViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoInterstitialBasicIntegrationViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate
{
    private var interstitial: ALInterstitialAd!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // If creating an instance of `ALInterstitialAd`, you must store it in a pproperty so it doesn't get dealloc'd by ARC
        // Alternatively, you can use `ALInterstitialAd.shared()`
        self.interstitial = ALInterstitialAd(sdk: ALSdk.shared()!)
        self.interstitial.adLoadDelegate = self
        self.interstitial.adDisplayDelegate = self
        self.interstitial.adVideoPlaybackDelegate = self
    }
    
    // MARK: IB Action Methods
    
    @IBAction func showInterstitial(_ sender: AnyObject!)
    {
        if self.interstitial.isReadyForDisplay
        {
            self.interstitial.show()
            self.log("Interstitial Shown")
        }
        else
        {
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
