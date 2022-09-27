//
//  DashboardViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/21/22.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var groceriesButton: UIButton!
    @IBOutlet weak var beautyButton: UIButton!
    @IBOutlet weak var elecButton: UIButton!
    @IBOutlet weak var fashionButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if name != nil{
            nameLabel.text = name!
        }
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func groceriesClicked(_ sender: Any) {
        let groc = storyboard?.instantiateViewController(withIdentifier: "SelecCatVC") as! SelectedCategoryViewController
        groc.passcategory = "groceries"
        self.navigationController?.pushViewController(groc, animated: true)
    }
    
    @IBAction func fashionClicked(_ sender: Any) {
        let fashion = storyboard?.instantiateViewController(withIdentifier: "SelecCatVC") as! SelectedCategoryViewController
        fashion.passcategory = "womens-dresses"
        self.navigationController?.pushViewController(fashion, animated: true)
    }
    
    @IBAction func electronicClicked(_ sender: Any) {
        let elec = storyboard?.instantiateViewController(withIdentifier: "SelecCatVC") as! SelectedCategoryViewController
        elec.passcategory = "smartphones"
        self.navigationController?.pushViewController(elec, animated: true)
    }
    
    @IBAction func beautyClicked(_ sender: Any) {
        let beauty = storyboard?.instantiateViewController(withIdentifier: "SelecCatVC") as! SelectedCategoryViewController
        beauty.passcategory = "skincare"
        self.navigationController?.pushViewController(beauty, animated: true)
    }
    
    @IBAction func loadMoreCategoriesClicked(_ sender: Any) {
        let beauty = storyboard?.instantiateViewController(withIdentifier: "tabcategories")
        self.navigationController?.pushViewController(beauty!, animated: true)
    }
    
}
