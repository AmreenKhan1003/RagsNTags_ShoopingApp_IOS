//
//  CategoriesViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/23/22.
//

import UIKit
import Alamofire

class CategoryCell: UITableViewCell{
    
    @IBOutlet weak var categoryName: UILabel!
    
    
}

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var categoryTable: UITableView!
    var categories = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thirdpartyService()
    }
    
    func thirdpartyService(){
        
        Alamofire.request("https://dummyjson.com/products/categories", method: .get, encoding: URLEncoding.default, headers: nil).responseData{
            response in
            switch response.result{
            case .success:
                if let dict = response.value {
                    //call fuction to parse json
                    self.parsejson(jsonCategories: dict)
                    
                }
                break
            case .failure(let error):
                print(error)
            }
        }
        
    }//end function
    
    
    func parsejson(jsonCategories: Data){
        do {
            let categoryList = try JSONSerialization.jsonObject(with: jsonCategories) as? [String]
            
            for category in categoryList ?? []{
                categories.add(category)
            }
            
            DispatchQueue.main.async {
                self.categoryTable.delegate = self
                self.categoryTable.dataSource = self
                self.categoryTable.reloadData()
            }//END OF DISPATCHQUEUEfast.com
             
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.categoryTable.dequeueReusableCell(withIdentifier: "catgoryCell", for: indexPath) as! CategoryCell
        cell.categoryName.text = categories[indexPath.row] as? String
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rslt:String = categories[indexPath.row] as! String
        let categoryDetailVC = storyboard?.instantiateViewController(withIdentifier: "SelecCatVC") as! SelectedCategoryViewController
        categoryDetailVC.passcategory = rslt
        self.navigationController?.pushViewController(categoryDetailVC, animated: true)
        print(rslt)
        
        
    }
    
    @IBAction func logOutisClicked(_ sender: Any) {
        let dele = CoreDataCart()
        dele.deleteAllItems()
        let navHome = storyboard?.instantiateViewController(withIdentifier: "loginVC")
        self.navigationController?.pushViewController(navHome!, animated: true)
    }

    

}
