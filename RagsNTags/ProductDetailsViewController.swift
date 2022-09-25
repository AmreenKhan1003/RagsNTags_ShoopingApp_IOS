//
//  ProductDetailsViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/23/22.
//

import UIKit
import CoreData

class CoreDataCart{
    
    func deleteItem(item: String) {
        // Delete the user-selected item from the context
        let store = (UIApplication.shared.delegate) as! AppDelegate
        let viewContext = store.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CartData> = CartData.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "itemName == %@", "\(item)")

        if let result = try? viewContext.fetch(fetchRequest) {
            for object in result {
                viewContext.delete(object)
            }
        }

        do {
            try viewContext.save()
        } catch {
            //Handle error
            print("Error while deleting")
        }
        // Delete the user-selected item from the data source
        

        // Save changes to the Managed Object Context
        //store.saveContext()
    }
    

    
    func fetchname() -> NSMutableArray {
        
        let carts = NSMutableArray()
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do{
            let cartdata = try context.fetch(CartData.fetchRequest()) as! [CartData]
            
            for data in cartdata{
                //print(data.itemName)
                carts.add(data.itemName)
                
            }//end for
            
        }//end do
        catch{
            print("error occured while fetching name")
        }
         
        
            return carts
        
    }
    
    func fetchPrice() -> NSMutableArray{
        let carts = NSMutableArray()
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do{
            let cartdata = try context.fetch(CartData.fetchRequest()) as! [CartData]
            
            for data in cartdata{
                //print(data.itemName)
                carts.add(data.itemPrice)
                
            }//end for
            
        }//end do
        catch{
            print("error occured while fetching Price")
        }
         
        
            return carts
    }
    
    func fetchImg() -> NSMutableArray{
        
        let carts = NSMutableArray()
        
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do{
            let cartdata = try context.fetch(CartData.fetchRequest()) as! [CartData]
            
            for data in cartdata{
                //print(data.itemName)
                carts.add(data.itemImg)
                
            }//end for
            
        }//end do
        catch{
            print("error occured while fetching name")
        }
         
        
            return carts
    }
    
    func registerOnCoreData(name: String, price: String, img: String) -> Bool{
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let itemData = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: context) as! CartData

        do{
            let cartdata = try context.fetch(CartData.fetchRequest()) as! [CartData]
            //print(edata)
            
            //no same item is present so enter item in coreData
            
            itemData.itemName = name
            itemData.itemPrice = price
            itemData.itemImg = img
                do{
                    try context.save()
                    print("cart Data has been stored")
                    return true
                }
                catch {
                    print("Cant load")
                    return false
                }
            
            
        }
        catch{
            print("Error occured while storing data")
            return false
        }
        
    }
    
}



class ProductDetailsViewController: UIViewController {
    
    var passName: String?
    var passDesc: String?
    var passPrice: String?
    var passImg: String?
    
    var storeitem = CoreDataCart()
    
    
    @IBOutlet weak var titles: UILabel!
    @IBOutlet weak var imgDisplay: UIImageView!
    
    @IBOutlet weak var priceDisplay: UILabel!
    @IBOutlet weak var descDisplay: UILabel!
    
    //var cartItem = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(storeitem.registerOnCoreData(name: passName!, price: passPrice!, img: passImg!))
        //print(storeitem.fetchname())
        //print(passName)
        titles.text = passName!
        
        do{
            let recievedimg = try? Data(contentsOf: URL(string: passImg!)!)
            imgDisplay.image = UIImage(data: recievedimg!)
        }
        
        descDisplay.text = passDesc!
        priceDisplay.text = passPrice!
        
        

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addToCartClicked(_ sender: Any) {
        let carts = storyboard?.instantiateViewController(withIdentifier: "cartVC") as! CartViewController
        carts.passItem = passName!
        carts.passPrice = passPrice!
        carts.passImg = passImg!
        
        
    }
    

}
