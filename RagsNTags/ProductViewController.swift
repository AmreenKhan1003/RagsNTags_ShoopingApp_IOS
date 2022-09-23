//
//  ProductViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/22/22.
//

import UIKit

class ProductViewController: UIViewController {
    
    var passName: String??
    var passDesc: String??
    var passPrice: String??
    var passImg: UIImage??
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(passImg!!, passDesc!! as Any, passName, passPrice)
    }

}
