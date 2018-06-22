//
//  ALDemoInterstitialZoneViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Suyash Saxena on 6/19/18.
//  Copyright © 2018 AppLovin. All rights reserved.
//

import UIKit

class ALDemoInterstitialZoneViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate
{
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    var ad: ALAd?
    
    @IBAction func loadInterstitial(_ sender: AnyObject!)
    {
        self.log("Interstitial loading...")
        ALSdk.shared()?.adService.loadNextAd(forZoneIdentifier: "YOUR_ZONE_ID", andNotify: self)
    }
    
    @IBAction func showInterstitial(_ sender: AnyObject!)
    {
        if let ad = self.ad
        {
            // Optional: Assign delegates
            ALInterstitialAd.shared().adDisplayDelegate = self
            ALInterstitialAd.shared().adVideoPlaybackDelegate = self
            
            ALInterstitialAd.shared().showOver(UIApplication.shared.keyWindow!, andRender: ad)
            
            self.log("Interstitial Shown");
        }
    }
    
    // MARK: Ad Load Delegate
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.log("Interstitial Loaded")
        
        self.ad = ad
        self.showButton.isEnabled = true
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

