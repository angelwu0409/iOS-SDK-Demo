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
    let kMRecWidth: CGFloat = 300
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let adView = ALAdView(size: .sizeMRec())
        
        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        
        adView.loadNextAd()
        
        self.view.addSubview(adView)
        
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
}
