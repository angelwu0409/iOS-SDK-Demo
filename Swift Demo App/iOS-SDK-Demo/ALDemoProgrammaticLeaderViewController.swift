//
//  ALDemoProgrammaticLeaderViewController.swift
//  iOS-SDK-Demo-Swift
//
//  Created by Santosh Bagadi on 4/5/18.
//  Copyright © 2018 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

class ALDemoProgrammaticLeaderViewController: ALDemoBaseViewController, ALAdLoadDelegate, ALAdDisplayDelegate, ALAdViewEventDelegate
{
    let kLeaderHeight: CGFloat = 90

    // Create the leader view
    var adView = ALAdView(size: .sizeLeader())

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
            NSLayoutConstraint(item: adView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: kLeaderHeight)
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
        self.log("Leader Loaded")
    }

    func adService(_ adService: ALAdService, didFailToLoadAdWithError code: Int32)
    {
        // Look at ALErrorCodes.h for list of error codes
        self.log("Leader failed to load with error code \(code)")
        loadButton.isEnabled = true
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

    // MARK: Ad View Event Delegate

    func ad(_ ad: ALAd, didPresentFullscreenFor adView: ALAdView)
    {
        self.log("Leader did present fullscreen")
    }

    func ad(_ ad: ALAd, willDismissFullscreenFor adView: ALAdView)
    {
        self.log("Leader will dismiss fullscreen")
    }

    func ad(_ ad: ALAd, didDismissFullscreenFor adView: ALAdView)
    {
        self.log("Leader did dismiss fullscreen")
    }

    func ad(_ ad: ALAd, willLeaveApplicationFor adView: ALAdView)
    {
        self.log("Leader will leave application")
    }

    func ad(_ ad: ALAd, didReturnToApplicationFor adView: ALAdView)
    {
        self.log("Leader did return to application")
    }

    func ad(_ ad: ALAd, didFailToDisplayIn adView: ALAdView, withError code: ALAdViewDisplayErrorCode)
    {
        self.log("Leader did fail to display with error code: \(code)")
    }
}
