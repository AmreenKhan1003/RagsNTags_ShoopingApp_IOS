//
//  GroceriesViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/22/22.
//

import UIKit
import AlertsAndNotifications

class GroceriesViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func notice(_ sender: Any) {
        
        
        
        let not = Notifications()
        not.sendnotice()
        
        
    }
    
    

}
