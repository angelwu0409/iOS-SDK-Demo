//
//  ALDemoProgrammaticMRecViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Thomas So on 3/6/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALDemoProgrammaticMRecViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdViewEventDelegate
{
    let kMRecHeight: CGFloat = 250
    let kMRecWidth: CGFloat = 300
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        // Create the MRec view
        let adView = ALAdView(size: .sizeMRec())
        
        // Optional: Implement the ad delegates to receive ad events.
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.adEventDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        
        // Call loadNextAd() to start showing ads
        adView.loadNextAd()
        
        self.view.addSubview(adView)
        
        // Center the MRec.
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            adView.centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            adView.centerYAnchor.constraint(equalTo: margins.centerYAnchor),
            adView.widthAnchor.constraint(equalToConstant: kMRecWidth),
            adView.heightAnchor.constraint(equalToConstant: kMRecHeight)
            ])
    }
    
    // MARK: Ad Load Delegate
    
    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.log("MRec Loaded")
    }
    
    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("MRec failed to load with error code \(code)")
    }
    
    // MARK: Ad Display Delegate
    
    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("MRec Displayed")
    }
    
    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("MRec Dismissed")
    }
    
    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("MRec Clicked")
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
