//
//  MobileViewController.swift
//  RagsNTags
//
//  Created by Capgemini-DA322 on 9/22/22.
//

import UIKit

struct Details: Codable{
    var name: String
    var desc: String
    var price: String
    var img: String
}
struct Product: Codable{
    var Mobiles: [Details]
    var Clothes: [Details]
    var Groceries: [Details]
    var Beauty: [Details]
}

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDesc: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
            
    }
}

class MobileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableviewObject: UITableView!
    
    //MARK: array to store parse data and display it on table
    var namearray = NSMutableArray()
    var descarray = NSMutableArray()
    var pricearray = NSMutableArray()
    var imgarray = ["m1", "m2", "m3", "m4", "m5", "m6", "m7", "m8", "m9", "m10"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // call parser
        producttoparse()
    }
    
    //MARK: fuction to parse Mobile data from json
    func producttoparse(){
        let decoder = JSONDecoder()
        if let path = Bundle.main.path(forResource: "products", ofType: "json"){
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsondata = try decoder.decode(Product.self, from: data)
                print(jsondata.Mobiles.count)
                
                for i in 0...jsondata.Mobiles.count-1{
                    namearray.add(jsondata.Mobiles[i].name)
                    descarray.add(jsondata.Mobiles[i].desc)
                    pricearray.add(jsondata.Mobiles[i].price)
                    //let url = NSURL(string: jsondata.Beauty[i].img)
                    //let data = NSData(contentsOf: url as! URL)
                    //imagearray.add(jsondata.Beauty[i].img)
                }
                print(namearray)
                print(descarray)
                print(pricearray)
                //print(imagearray)
                print(jsondata.Beauty[0].img)
                
                DispatchQueue.main.async {
                    self.tableviewObject.delegate = self
                    self.tableviewObject.dataSource = self
                    self.tableviewObject.reloadData()
                }//END OF DISPATCHQUEUEfast.com
                
            }//END OF DO
            catch let errors{
                print("Error while parsing users: \(errors.localizedDescription)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableviewObject.dequeueReusableCell(withIdentifier: "mobilecell", for: indexPath) as! TableViewCell
        cell.productTitle.text = (namearray[indexPath.row] as AnyObject) as? String
        cell.productDesc.text = (descarray[indexPath.row] as AnyObject) as? String
        cell.productPrice.text = (pricearray[indexPath.row] as AnyObject) as? String
        
        cell.productImage.image = UIImage(named: (imgarray[indexPath.row] + ".jpg"))
        return cell
    }

}
