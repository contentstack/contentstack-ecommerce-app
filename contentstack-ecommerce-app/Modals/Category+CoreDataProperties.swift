//
//  Category+CoreDataProperties.swift
//  
//
//  Created by Uttam Ukkoji on 03/12/18.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func categoryFetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var uid: String?
    @NSManaged public var order: Double

}
