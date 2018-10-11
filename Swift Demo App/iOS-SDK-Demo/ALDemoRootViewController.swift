//
//  ALDemoRootViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices

class ALDemoRootViewController: UITableViewController, MFMailComposeViewControllerDelegate
{
    let kSupportEmail = "support@applovin.com"
    let kSupportLink = "https://support.applovin.com/support/home"

    let kRowIndexToHideForPhones = 5;
    
    @IBOutlet var muteToggle: UIBarButtonItem!
    
    // MARK: View Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.setToolbarHidden(true, animated: false)
        
        let logo = UIImageView(image: UIImage(named: "nav_logo"))
        logo.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        logo.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logo
        
        self.addFooterLabel()
        
        self.muteToggle.image = muteIconForCurrentSdkMuteSetting()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        // Re-set status bar style after returning from SFSafariViewController
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        let sdkKey = Bundle.main.infoDictionary!["AppLovinSdkKey"] as! String
        if sdkKey == "YOUR_SDK_KEY"
        {
            let alertVC = UIAlertController(title: "ERROR", message: "Please update the `AppLovinSdkKey` row in your Info.plist file with your SDK key.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    // MARK: Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1
        {
            if indexPath.row == 0
            {
                openSupportSite()
            }
            else if indexPath.row == 1
            {
                attemptSendEmail()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        if UIDevice.current.userInterfaceIdiom == .phone && indexPath.section == 0 && indexPath.row  == kRowIndexToHideForPhones
        {
            cell.isHidden = true;
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if UIDevice.current.userInterfaceIdiom == .phone && indexPath.section == 0 && indexPath.row  == kRowIndexToHideForPhones
        {
            return 0;
        }

        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    // MARK: Sound Toggling

    @IBAction func toggleMute(_ sender: UIBarButtonItem!)
    {
        /**
         * Toggling the sdk mute setting will affect whether your video ads begin in a muted state or not.
         */
        let sdk = ALSdk.shared()
        sdk?.settings.muted = !(sdk?.settings.muted)!
        sender.image = muteIconForCurrentSdkMuteSetting()
    }
    
    func muteIconForCurrentSdkMuteSetting() -> UIImage!
    {
        return ALSdk.shared()!.settings.muted ? UIImage(named: "mute") : UIImage(named: "unmute")
    }
    
    // MARK: Table View Actions
    
    func openSupportSite()
    {
        guard let supportURL = URL(string: kSupportLink) else { return }
        
        if #available(iOS 9.0, *)
        {
            let safariController = SFSafariViewController(url: supportURL, entersReaderIfAvailable: true)
            self.present(safariController, animated: true, completion: {
                UIApplication.shared.statusBarStyle = .default
            })
        }
        else
        {
            UIApplication.shared.openURL(supportURL)
        }
    }
    
    func attemptSendEmail()
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mailController = MFMailComposeViewController()
            mailController.mailComposeDelegate = self
            mailController.setSubject("iOS SDK Support")
            mailController.setToRecipients([kSupportEmail])
            mailController.setMessageBody("\n\n---\nSDK Version: \(ALSdk.version())", isHTML: false)
            mailController.navigationBar.tintColor = UIColor.white
            
            self.present(mailController, animated: true, completion: {
                UIApplication.shared.statusBarStyle = .lightContent
            })
        }
        else
        {
            let message = "Your device is not configured for sending emails.\n\nPlease send emails to \(kSupportEmail)"
            let alertVC = UIAlertController(title: "Email Unavailable", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        switch ( result.rawValue )
        {
        case ( MFMailComposeResult.sent.rawValue ):
            let alertVC = UIAlertController(title: "Email Sent", message: "Thank you for your email, we will process it as soon as possible.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alertVC.addAction(okAction)
            self.present(alertVC, animated: true, completion: nil)
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func addFooterLabel()
    {
        let footer = UILabel()
        footer.font = UIFont.systemFont(ofSize: 14)
        footer.numberOfLines = 0
        
        let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let sdkVersion = ALSdk.version()
        let systemVersion = UIDevice.current.systemVersion
        let text = "App Version: \(appVersion)\nSDK Version: \(sdkVersion)\niOS Version: \(systemVersion)\n\nLanguage: Swift"
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.minimumLineHeight = 20
        footer.attributedText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle : style])
        
        var frame = footer.frame
        frame.size.height = footer.sizeThatFits(CGSize(width: footer.frame.width, height: CGFloat.greatestFiniteMagnitude)).height + 60
        footer.frame = frame
        self.tableView.tableFooterView = footer
    }
}
