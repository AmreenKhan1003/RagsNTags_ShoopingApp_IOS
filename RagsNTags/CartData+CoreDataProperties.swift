//
//  CartData+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA322 on 9/24/22.
//
//

import Foundation
import CoreData


extension CartData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartData> {
        return NSFetchRequest<CartData>(entityName: "CartData")
    }

    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: String?
    @NSManaged public var itemImg: String?

}
