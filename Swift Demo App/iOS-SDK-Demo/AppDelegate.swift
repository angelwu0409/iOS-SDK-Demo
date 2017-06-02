//
//  AppDelegate.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

@UIApplicationMain
class ALDemoAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        // Initializing our SDK at launch is very important as it'll start preloading ads in the background.        
        ALSdk.initializeSdk()
        
        ALSdk.shared()?.settings.isTestAdsEnabled = true

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red: 10.0/255.0, green: 131.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        
        let sdkKey = Bundle.main.infoDictionary!["AppLovinSdkKey"] as! String
        if sdkKey == "YOUR_SDK_KEY"
        {
            UIAlertView(title: "ERROR",
                        message: "Please update the `AppLovinSdkKey` row in your Info.plist file with your SDK key.",
                        delegate: nil,
                        cancelButtonTitle: "OK").show()
        }
        
        return true
    }
}
