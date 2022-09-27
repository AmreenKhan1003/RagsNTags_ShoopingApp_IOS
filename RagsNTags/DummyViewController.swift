//
//  DummyViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/27/22.
//

import UIKit
import AlertsAndNotifications

class DummyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func checknoti(_ sender: Any) {
        let not = Notifications()
        not.sendnotice()
    }
    

}
