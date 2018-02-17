//
//  ALDemoProgrammaticBannerViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Thomas So on 3/6/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALDemoProgrammaticBannerViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate
{
    var adView: ALAdView?
    @IBOutlet weak var loadButton: UIBarButtonItem!
    
    let kBannerHeight: CGFloat = 50
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear( animated )
        
        adView = ALAdView(sdk: ALSdk.shared()!, size: .sizeBanner())
        
        if let adView = adView
        {
            adView.adLoadDelegate = self
            adView.adDisplayDelegate = self
    
            adView.loadNextAd()
            
            self.view.addSubview(adView)
        }
    }
    
    @IBAction func loadNextAd(_ sender: UIBarButtonItem)
    {
        adView?.loadNextAd()
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
}
