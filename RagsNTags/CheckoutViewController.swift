//
//  CheckoutViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/24/22.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var totalAmount: UILabel!
    var passPriceArray = NSMutableArray()
    var totalamounts = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        print(passPriceArray)
        let intArray = passPriceArray.map { Int($0 as! String)!}
        print(intArray)
        for i in intArray{
            totalamounts += i
        }
        print(totalamounts)
        
        totalAmount.text = String(totalamounts)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func payIsClicked(_ sender: Any) {
        
        let order = storyboard?.instantiateViewController(withIdentifier: "maps") as! MapUserViewController
        self.navigationController?.pushViewController(order, animated: true)
    }
    
    

}
