//
//  ThankYouViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/25/22.
//

import UIKit
import AlertsAndNotifications

class ThankYouViewController: UIViewController {
    
    var passName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okIsClicked(_ sender: Any) {
        //Call notification from framework
        let not = Notifications()
        not.sendnotice()
        
        //Clear the cart as Items are bought
        let clearCart = CoreDataCart()
        clearCart.deleteAllCartItems()
        
        //Move the user to dashboard
        let backtohome = storyboard?.instantiateViewController(withIdentifier: "dash") as! DashboardViewController
        backtohome.name = nameUser!
        self.navigationController?.pushViewController(backtohome, animated: true)
        
    }
    
    

}
