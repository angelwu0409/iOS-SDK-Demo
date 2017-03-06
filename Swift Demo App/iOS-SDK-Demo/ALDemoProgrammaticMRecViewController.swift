//
//  ALDemoProgrammaticMRecViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Thomas So on 3/6/17.
//  Copyright © 2017 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALDemoProgrammaticMRecViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate
{
    let kMRecHeight: CGFloat = 250
    let kMRecWidth: CGFloat = 320
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear( animated )
        
        let frame = CGRect(x: self.view.bounds.midX - kMRecWidth/2, y: 80, width: kMRecWidth, height: kMRecHeight)
        let adView = ALAdView(frame: frame, size: ALAdSize.sizeMRec(), sdk: ALSdk.shared()!)
        
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        
        adView.loadNextAd()
        
        self.view.addSubview(adView);
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
}
