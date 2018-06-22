//
//  ALDemoBannerZoneViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Suyash Saxena on 6/19/18.
//  Copyright © 2018 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALDemoBannerZoneViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdViewEventDelegate
{
    let kBannerHeight: CGFloat = 50
    
    // Create the banner view
    var adView = ALAdView(size: ALAdSize.sizeBanner(), zoneIdentifier: "YOUR_ZONE_ID")
    
    @IBOutlet weak var loadButton: UIBarButtonItem!
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Optional: Implement the ad delegates to receive ad events.
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.adEventDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        
        // Call loadNextAd() to start showing ads
        adView.loadNextAd()
        
        view.addSubview(adView)
        
        // Center the banner and anchor it to the bottom of the screen.
        // Alternatively, you can manually set the banner's frames or use the Interface Builder as seen in the ALDemoInterfaceBuilderBannerViewController.swift example.
        view.addConstraints([
            NSLayoutConstraint(item: adView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: adView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: adView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0),
            NSLayoutConstraint(item: adView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: kBannerHeight)
            ])
    }
    
    @IBAction func loadNextAd(_ sender: UIBarButtonItem)
    {
        adView.loadNextAd()
        
        sender.isEnabled = false
    }
    
    // MARK: Ad Load Delegate
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.log("Banner Loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Banner failed to load with error code \(code)")
        
        loadButton.isEnabled = true
    }
    
    // MARK: Ad Display Delegate
    
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("Banner Displayed")
        
        loadButton.isEnabled = true
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("Banner Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("Banner Clicked")
    }
    
    // MARK: Ad View Event Delegate
    
    func ad(_ ad: ALAd, didPresentFullscreenFor adView: ALAdView)
    {
        self.log("Banner did present fullscreen")
    }
    
    func ad(_ ad: ALAd, willDismissFullscreenFor adView: ALAdView)
    {
        self.log("Banner will dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, didDismissFullscreenFor adView: ALAdView)
    {
        self.log("Banner did dismiss fullscreen")
    }
    
    func ad(_ ad: ALAd, willLeaveApplicationFor adView: ALAdView)
    {
        self.log("Banner will leave application")
    }
    
    func ad(_ ad: ALAd, didReturnToApplicationFor adView: ALAdView)
    {
        self.log("Banner did return to application")
    }
    
    func ad(_ ad: ALAd, didFailToDisplayIn adView: ALAdView, withError code: ALAdViewDisplayErrorCode)
    {
        self.log("Banner did fail to display with error code: \(code)")
    }
}
