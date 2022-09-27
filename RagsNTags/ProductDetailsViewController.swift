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
        
    }
    
    func deleteAllCartItems(){
        /*
        let store = (UIApplication.shared.delegate) as! AppDelegate
        let viewContext = store.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CartData> = CartData.fetchRequest()
            fetchRequest.returnsObjectsAsFaults = false

            do
            {
                let results = try viewContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as NSManagedObject
                    viewContext.delete(managedObjectData)
                }
                print("cart data has been deleted")
            } catch let error as NSError {
                print("Detele all data in \(error.userInfo)")
            }*/
        let user = CoreDataFetch()
        let fetchuser = user.fetchData(email: emailIDUser!)
        let store = (UIApplication.shared.delegate) as! AppDelegate
        let viewContext = store.persistentContainer.viewContext
        //let fetchRequest: NSFetchRequest<CartData> = CartData.fetchRequest()
        
        do{
            //let results = try viewContext.fetch(fetchRequest)
            for managedObject in fetchuser!.toCart!{
                //let data: NSManagedObject = managedObject.toCart! as NSManagedObject
                print(managedObject)
                viewContext.delete(managedObject as! NSManagedObject)
                
            }
            print("Cart Data is deleted")
        }catch let error as NSError{
            print("error while deleting cart data \(error.localizedDescription)")
        }
    }
    

    
    func fetchname() -> NSMutableArray {
        
        let carts = NSMutableArray()
        
        let users = CoreDataFetch()
        let fetchUser = users.fetchData(email: emailIDUser!)
        let cartProductArray = fetchUser?.toCart?.allObjects as! [CartData]
        for i in cartProductArray{
            carts.add(i.itemName!)
        }
            return carts
        
    }
    
    func fetchPrice() -> NSMutableArray{
        let carts = NSMutableArray()
        
        let users = CoreDataFetch()
        let fetchUser = users.fetchData(email: emailIDUser!)
        let cartProductArray = fetchUser?.toCart?.allObjects as! [CartData]
        for i in cartProductArray{
            carts.add(i.itemPrice!)
        }
        
            return carts
    }
    
    func fetchImg() -> NSMutableArray{
        
        
        let carts = NSMutableArray()
        
        let users = CoreDataFetch()
        let fetchUser = users.fetchData(email: emailIDUser!)
        let cartProductArray = fetchUser?.toCart?.allObjects as! [CartData]
        for i in cartProductArray{
            carts.add(i.itemImg!)
        }
            return carts
         
    }
    
    func fetchUser() -> String{
        
        var emailCart: String?
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        do{
            let cartdata = try context.fetch(CartData.fetchRequest()) as! [CartData]
            
            for data in cartdata{
                //print(data.itemName)
                if emailIDUser == data.touser?.email{
                    emailCart = emailIDUser
                }
                
            }//end for
            
        }//end do
        catch{
            print("error occured while fetching name")
        }
         
        if (emailCart != nil){
            return emailCart!
        }
        else{
            return " "
        }
        
    }
    
    func registerOnCoreData(name: String, price: String, img: String) -> Bool{
    let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let itemData = NSEntityDescription.insertNewObject(forEntityName: "CartData", into: context) as! CartData

        do{
            let cartdata = try context.fetch(CartData.fetchRequest()) as! [CartData]
            //print(edata)
            
            //no same item is present so enter item in coreData
            let userdata = CoreDataFetch()
            itemData.itemName = name
            itemData.itemPrice = price
            itemData.itemImg = img
            itemData.touser = userdata.fetchData(email: emailIDUser!)
            
            
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
    /*
    @IBAction func logOutisClicked(_ sender: Any) {
        let dele = CoreDataCart()
        dele.deleteAllItems()
        let navHome = storyboard?.instantiateViewController(withIdentifier: "loginVC")
        self.navigationController?.pushViewController(navHome!, animated: true)
    }*/
    
    func callAlerts(titles: String, messages: String){
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel) { (action) in
         // Respond to user selection of the action.
        }
        
        // Create and configure the alert controller.
        let alert = UIAlertController(title: titles,
              message: messages,
              preferredStyle: .alert)
        alert.addAction(cancelAction)
        
             
        self.present(alert, animated: true) {
           // The alert was presented
        }
    }

    @IBAction func addToCartClicked(_ sender: Any) {
        
        print(storeitem.registerOnCoreData(name: passName!, price: passPrice!, img: passImg!))
        let carts = storyboard?.instantiateViewController(withIdentifier: "cartVC") as! CartViewController
        carts.passItem = passName!
        carts.passPrice = passPrice!
        carts.passImg = passImg!
        callAlerts(titles: "Added to cart", messages: "Your product is added to cart.")
        
        
    }
    

}
