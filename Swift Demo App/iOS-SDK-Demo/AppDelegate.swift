//
//  AppDelegate.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit
import AppLovinSDK

@UIApplicationMain
class ALDemoAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        
        ALSdk.initializeSdk { (configuration: ALSdkConfiguration) in
            // SDK finished initialization
        }
        
        ALSdk.shared()!.settings.isTestAdsEnabled = true

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor(red: 10.0/255.0, green: 131.0/255.0, blue: 170.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    
        UINavigationBar.appearance().tintColor = UIColor.white
        
        return true
    }
}
