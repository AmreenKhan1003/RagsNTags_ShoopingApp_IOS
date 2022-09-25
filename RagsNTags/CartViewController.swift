//
//  CartViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/23/22.
//

import UIKit

class CartCell: UITableViewCell{
    
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var cartName: UILabel!
    @IBOutlet weak var cartPrice: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
            
    }
}

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var flag = 0
    
    @IBOutlet weak var cartTableView: UITableView!
    
    var passItem: String?
    var passImg: String?
    var passPrice: String?
    
    var cartItems = NSMutableArray()
    var cartItemsPrice = NSMutableArray()
    var cartItemsImg = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storeitem = CoreDataCart()
        cartItems = storeitem.fetchname()
        cartItemsImg = storeitem.fetchImg()
        cartItemsPrice = storeitem.fetchPrice()
        print(cartItemsImg)
        
        print(storeitem.fetchname())
        DispatchQueue.main.async {
            self.cartTableView.delegate = self
            self.cartTableView.dataSource = self
            self.cartTableView.reloadData()
        }//END OF DISPATCHQUEUE
    }
    
    
    @IBAction func buyNowClicked(_ sender: Any) {
        
        let categoryDetailVC = storyboard?.instantiateViewController(withIdentifier: "checkOut") as! CheckoutViewController
        categoryDetailVC.passPriceArray = cartItemsPrice
        self.navigationController?.pushViewController(categoryDetailVC, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.cartTableView.dequeueReusableCell(withIdentifier: "cartcell", for: indexPath) as! CartCell
        cell.cartName.text = (cartItems[indexPath.row] as AnyObject) as? String
        cell.cartPrice.text = (cartItemsPrice[indexPath.row] as AnyObject) as? String
        
        guard let recievedimg = try? Data(contentsOf: URL(string: cartItemsImg[indexPath.row] as! String)!)
        else{
            return cell
        }
        cell.cartImage.image = UIImage(data: recievedimg)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let deleteCartItem = cartItems[indexPath.row]
        print(deleteCartItem)
        
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let deleteCartItem = cartItems[indexPath.row]
            let dele = CoreDataCart()
            dele.deleteItem(item: deleteCartItem as! String)
            
            cartItems.removeAllObjects()
            cartItems = dele.fetchname()
            cartTableView.reloadData()
                    
        }
    }
    
    
    /*
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if (editingStyle == .delete){
            cartTableView.beginUpdates()
            
        }
    }
     */

}
