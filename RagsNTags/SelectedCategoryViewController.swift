//
//  HomeDecorationViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/22/22.
//

import UIKit
import Alamofire

struct Detailed: Codable{
    var id: Int
    var title: String
    var description: String
    var thumbnail: String
    var price: Int
}

struct HomeProduct: Codable{
    var products: [Detailed]
}

class HomeTableViewCell: UITableViewCell{
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
            
    }
}


class SelectedCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Array to store data parsed from json
    var namearray = NSMutableArray()
    var descarray = NSMutableArray()
    var pricearray = NSMutableArray()
    var imgarray = NSMutableArray()
    var passcategory: String?
    
    var nameCart: String?
    //MARK: Table view to display data
    @IBOutlet weak var homeTableView: UITableView!
    
    var pros = [Detailed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        thirdpartyService()
    }
    
    //MARK: Thirdparty integration using alamofire
    func thirdpartyService(){
        let url = "https://dummyjson.com/products/category/"+passcategory!
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil).responseData{
            response in
            switch response.result{
            case .success:
                if let dict = response.value {
                    print(dict)
                    
                    self.parsejson(homedata: dict)
                }
                break
            case .failure(let error):
                print(error)
            }
        }
        
    }//end function
    
    //MARK: func†ion to parse json
    func parsejson(homedata: Data){
        do {
            let jsondata = try JSONDecoder().decode(HomeProduct.self, from: homedata)
            print(jsondata.products.count)
            print(jsondata.products[0].thumbnail)
            
            for i in 0...jsondata.products.count-1{
                namearray.add(jsondata.products[i].title)
                descarray.add(jsondata.products[i].description)
                let price = String(jsondata.products[i].price)
                pricearray.add(price)
                imgarray.add(jsondata.products[i].thumbnail)
            }
            
            print(pricearray)
            
            DispatchQueue.main.async {
                self.homeTableView.delegate = self
                self.homeTableView.dataSource = self
                self.homeTableView.reloadData()
            }//END OF DISPATCHQUEUE

            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    
    @IBAction func cartButtonClicked(_ sender: Any) {
        print(nameCart)
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.homeTableView.dequeueReusableCell(withIdentifier: "homecell", for: indexPath) as! HomeTableViewCell
        cell.productTitle.text = (namearray[indexPath.row] as AnyObject) as? String
        cell.productDesc.text = (descarray[indexPath.row] as AnyObject) as? String
        
        cell.productPrice.text = (pricearray[indexPath.row] as AnyObject) as? String
        
        guard let recievedimg = try? Data(contentsOf: URL(string: imgarray[indexPath.row] as! String)!)
        else{
            return cell
        }
        cell.productImage.image = UIImage(data: recievedimg)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = namearray[indexPath.row]
        nameCart = name as! String
        let desc = descarray[indexPath.row]
        let price = pricearray[indexPath.row]
        let image = imgarray[indexPath.row]
        let productDetails = storyboard?.instantiateViewController(withIdentifier: "proDetails") as! ProductDetailsViewController
        productDetails.passName = (name as! String)
        productDetails.passDesc = (desc as! String)
        productDetails.passPrice = (price as! String)
        productDetails.passImg = image as! String
        self.navigationController?.pushViewController(productDetails, animated: true)
    }

}


