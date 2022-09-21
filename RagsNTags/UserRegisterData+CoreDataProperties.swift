//
//  UserRegisterData+CoreDataProperties.swift
//  
//
//  Created by Capgemini-DA322 on 9/21/22.
//
//

import Foundation
import CoreData


extension UserRegisterData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRegisterData> {
        return NSFetchRequest<UserRegisterData>(entityName: "UserRegisterData")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var name: String?
    @NSManaged public var mobile: String?

}
