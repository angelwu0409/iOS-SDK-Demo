//
//  ALDemoNativeAdProgrammaticViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

// Additional documentation - https://applovin.com/integration#iosNative

class ALDemoNativeAdProgrammaticViewController: ALDemoBaseViewController, ALNativeAdLoadDelegate, ALNativeAdPrecacheDelegate, ALPostbackDelegate
{
    @IBOutlet weak var precacheButton: UIBarButtonItem!
    @IBOutlet weak var showButton: UIBarButtonItem!
    
    @IBOutlet weak var impressionStatusLabel: UILabel!
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rating: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mediaView: ALCarouselMediaView!
    @IBOutlet weak var ctaButton: UIButton!
    
    var nativeAd: ALNativeAd?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.appIcon.layer.masksToBounds = true
        self.appIcon.layer.cornerRadius = 3
        
        self.ctaButton.layer.masksToBounds = true
        self.ctaButton.layer.cornerRadius = 3
        
        setUIElementsHidden(true)
    }
    
    // MARK: Action Methods
    
    @IBAction func loadNativeAd(_ sender: AnyObject!)
    {
        self.log("Native ad loading...")
        
        self.precacheButton.isEnabled = false
        self.showButton.isEnabled = false
        
        self.impressionStatusLabel.text = "No impression to track"
        
        ALSdk.shared()?.nativeAdService.loadNativeAdGroup(ofCount: 1, andNotify: self)
    }
    
    @IBAction func precacheNativeAd(_ sender: AnyObject!)
    {
        // You can use our pre-caching to retrieve assets (app icon, ad image, ad video) locally. OR you can do it with your preferred caching framework.
        // iconURL, imageURL, videoURL needs to be retrieved manually before you can render them
        
        self.log("Native ad precaching...")
        
        if let ad = self.nativeAd
        {
            ALSdk.shared()?.nativeAdService.precacheResources(for: ad, andNotify: self)
        }
    }
    
    @IBAction func showNativeAd(_ sender: AnyObject!)
    {
        self.log("Native ad rendered")
        
        if let ad = self.nativeAd, let iconURL = ad.iconURL
        {
            if let imageData = try? Data(contentsOf: iconURL)
            {
                self.appIcon.image = UIImage(data: imageData ) // Local URL
            }
            
            self.titleLabel.text = ad.title
            self.descriptionLabel.text = ad.descriptionText
            self.ctaButton.setTitle(ad.ctaText, for: .normal)
            
            let starFilename = "Star_Sprite_\(ad.starRating?.stringValue)"
            self.rating.image = UIImage(named: starFilename)
            
            // NOTE - Videos have aspect ratio of 1:1.85
            self.mediaView.renderView(for:  ad)
            
            setUIElementsHidden(false)
            
            //
            // You are responsible for firing all necessary postback URLs
            //
            trackImpression(ad)
            
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func ctaPressed(_ sender: AnyObject!)
    {
        self.nativeAd?.launchClickTarget()
    }
    
    // MARK: Impression Tracking
    
    func trackImpression(_ ad: ALNativeAd!)
    {
        // Callbacks may not happen on main queue
        DispatchQueue.main.async {
            ad.trackImpressionAndNotify(self)
        }
    }
    
    func postbackService(_ postbackService: ALPostbackService, didExecutePostback postbackURL: URL)
    {
        // Callbacks may not happen on main queue
        DispatchQueue.main.async {
            // Impression tracked!
            self.impressionStatusLabel.text = "Impression tracked"
        }
    }
    
    func postbackService(_ postbackService: ALPostbackService, didFailToExecutePostback postbackURL: URL?, errorCode: Int)
    {
        // Callbacks may not happen on main queue
        DispatchQueue.main.async {
            // Impression could not be tracked. Retry the postback later.
            self.impressionStatusLabel.text = "Impression failed to track with error code \(errorCode)"
        }
    }
    
    // MARK: Native Ad Load Delegate
    
    func nativeAdService(_ service: ALNativeAdService, didLoadAds ads: [Any])
    {
        self.log("Native ad loaded, assets not retrieved yet.")
        
        // Callbacks may not happen on main queue
        DispatchQueue.main.async {
            self.nativeAd = ads.first as? ALNativeAd
            self.precacheButton.isEnabled = true
        }
    }
    
    func nativeAdService(_ service: ALNativeAdService, didFailToLoadAdsWithError code: Int)
    {
        self.log("Native ad failed to load with error code \(code)")
    }
    
    // MARK: Native Ad Precache Delegate
    
    func nativeAdService(_ service: ALNativeAdService, didPrecacheImagesFor ad: ALNativeAd)
    {
        self.log("Native ad precached images")
    }
    func nativeAdService(_ service: ALNativeAdService, didPrecacheVideoFor ad: ALNativeAd)
    {
        // This delegate method will get called whether an ad actually has a video to precache or not
        self.log("Native ad done precaching")
        
        // Callbacks may not happen on main queue
        DispatchQueue.main.async {
            self.showButton.isEnabled = true
            self.precacheButton.isEnabled = false
        }
    }
    
    func nativeAdService(_ service: ALNativeAdService, didFailToPrecacheImagesFor ad: ALNativeAd, withError errorCode: Int)
    {
        self.log("Native ad failed to precache images with error code \(errorCode)")
    }
    
    func nativeAdService(_ service: ALNativeAdService, didFailToPrecacheVideoFor ad: ALNativeAd, withError errorCode: Int)
    {
        self.log("Native ad failed to precache video with error code \(errorCode)")
    }
    
    // MARK: Utility
    
    func setUIElementsHidden(_ hidden: Bool)
    {
        self.appIcon.isHidden = hidden
        self.titleLabel.isHidden = hidden
        self.rating.isHidden = hidden
        self.descriptionLabel.isHidden = hidden
        self.mediaView.isHidden = hidden
        self.ctaButton.isHidden = hidden
    }
}
