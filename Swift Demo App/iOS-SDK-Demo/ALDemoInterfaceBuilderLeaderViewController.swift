//
//  ALDemoInterfaceBuilderLeaderViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Santosh Bagadi on 4/5/18.
//  Copyright © 2018 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALDemoInterfaceBuilderLeaderViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate
{
    @IBOutlet weak var adView: ALAdView!
    @IBOutlet weak var loadButton: UIBarButtonItem!

    // MARK: View Lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.adView.adLoadDelegate = self
        self.adView.adDisplayDelegate = self
    }

    @IBAction func loadNextAd(_ sender: UIBarButtonItem)
    {
        adView.loadNextAd()
    }

    // MARK: Ad Load Delegate

    func adService(_ adService: ALAdService, didLoad ad: ALAd)
    {
        self.log("Leader Loaded")
    }

    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Leader failed to load with error code \(code)")
    }

    // MARK: Ad Display Delegate

    func ad(_ ad: ALAd, wasDisplayedIn view: UIView)
    {
        self.log("Leader Displayed")

        loadButton.isEnabled = true
    }

    func ad(_ ad: ALAd, wasHiddenIn view: UIView)
    {
        self.log("Leader Dismissed")
    }

    func ad(_ ad: ALAd, wasClickedIn view: UIView)
    {
        self.log("Leader Clicked")
    }
}
