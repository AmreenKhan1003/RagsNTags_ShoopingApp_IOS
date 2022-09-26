//
//  UserRegisterData+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA322 on 9/26/22.
//
//

import Foundation
import CoreData


extension UserRegisterData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRegisterData> {
        return NSFetchRequest<UserRegisterData>(entityName: "UserRegisterData")
    }

    @NSManaged public var email: String?
    @NSManaged public var mobile: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var toCart: NSSet?

}

// MARK: Generated accessors for toCart
extension UserRegisterData {

    @objc(addToCartObject:)
    @NSManaged public func addToToCart(_ value: CartData)

    @objc(removeToCartObject:)
    @NSManaged public func removeFromToCart(_ value: CartData)

    @objc(addToCart:)
    @NSManaged public func addToToCart(_ values: NSSet)

    @objc(removeToCart:)
    @NSManaged public func removeFromToCart(_ values: NSSet)

}
