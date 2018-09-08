//
//  ALDemoBaseViewController.swift
//  iOS-SDK-Demo
//
//  Created by Thomas So on 9/25/15.
//  Copyright © 2015 AppLovin. All rights reserved.
//

import UIKit

class ALDemoBaseViewController: UIViewController
{
    @IBOutlet weak var adStatusLabel: UILabel?
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.navigationController?.setToolbarHidden(self.hidesBottomBarWhenPushed, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        self.navigationController?.setToolbarHidden(true, animated: false)
        super.viewWillDisappear(animated)
    }
    
    func log(_ message: String!)
    {
        DispatchQueue.main.async {
            if let label = self.adStatusLabel {
                label.text = message
            }
        };
    }
}
