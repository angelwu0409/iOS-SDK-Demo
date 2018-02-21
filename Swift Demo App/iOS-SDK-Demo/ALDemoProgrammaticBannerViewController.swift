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
    let kBannerHeight: CGFloat = 50
    
    var adView = ALAdView(size: .sizeBanner())
    
    @IBOutlet weak var loadButton: UIBarButtonItem!
    
    // MARK: View Lifecycle
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)

        adView.adLoadDelegate = self
        adView.adDisplayDelegate = self
        adView.translatesAutoresizingMaskIntoConstraints = false
        
        adView.loadNextAd()
        
        view.addSubview(adView)
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            adView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            adView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            adView.heightAnchor.constraint(equalToConstant: kBannerHeight)
            ])
    }
    
    @IBAction func loadNextAd(_ sender: UIBarButtonItem)
    {
        adView.loadNextAd()
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
