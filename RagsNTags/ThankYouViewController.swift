//
//  ThankYouViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/25/22.
//

import UIKit

class ThankYouViewController: UIViewController {
    
    var passName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func okIsClicked(_ sender: Any) {
        let backtohome = storyboard?.instantiateViewController(withIdentifier: "dash") as! DashboardViewController
        
        self.navigationController?.pushViewController(backtohome, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
