//
//  Product+CoreDataProperties.swift
//  
//
//  Created by Uttam Ukkoji on 06/12/18.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func productFetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var categories: String?
    @NSManaged public var desc: String?
    @NSManaged public var featuredImage: String?
    @NSManaged public var in_stock: Bool
    @NSManaged public var offetPrice: Double
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var uid: String?
    @NSManaged public var relatedProducts: [String]?
    @NSManaged public var date : Date?

}
