//
//  DashboardViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/21/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if name != nil{
        
        nameLabel.text = name!
        }
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func logOutisClicked(_ sender: Any) {
        let dele = CoreDataCart()
        dele.deleteAllItems()
        let navHome = storyboard?.instantiateViewController(withIdentifier: "loginVC")
        self.navigationController?.pushViewController(navHome!, animated: true)
    }
    
    @IBAction func groceriesClicked(_ sender: Any) {
        let groc = storyboard?.instantiateViewController(withIdentifier: "GroceriesVC")
        self.navigationController?.pushViewController(groc!, animated: true)
    }
    
    @IBAction func fashionClicked(_ sender: Any) {
        let fashion = storyboard?.instantiateViewController(withIdentifier: "FashionVC")
        self.navigationController?.pushViewController(fashion!, animated: true)
    }
    
    @IBAction func electronicClicked(_ sender: Any) {
        let elec = storyboard?.instantiateViewController(withIdentifier: "MobileVC")
        self.navigationController?.pushViewController(elec!, animated: true)
    }
    
    @IBAction func beautyClicked(_ sender: Any) {
        let beauty = storyboard?.instantiateViewController(withIdentifier: "BeautyVC")
        self.navigationController?.pushViewController(beauty!, animated: true)
    }
    
    //MARK: Load more categories
    @IBAction func loadMoreCategoriesClicked(_ sender: Any) {
        let beauty = storyboard?.instantiateViewController(withIdentifier: "tabcategories")
        self.navigationController?.pushViewController(beauty!, animated: true)    }
}
