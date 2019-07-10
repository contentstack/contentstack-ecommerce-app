//
//  NSManageObject+Addition.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 03/12/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import CoreData
extension NSManagedObjectContext {
    func deleteAll<T:NSManagedObject>(_ entity: T.Type) {
        let deleteList = self.findAll(entity)
        for manageObject in deleteList {
            self.delete(manageObject)
        }
        do {
            try self.save()
        }catch {
            
        }
    }
    
    func findAll<T:NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil, sortBy: [NSSortDescriptor]? = nil) -> [T] {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortBy
        
        let fetchedResult = try! self.fetch(fetchRequest)
        return fetchedResult
    }
    
    func findOrCreate<T:NSManagedObject>(_ entity: T.Type, predicate: NSPredicate? = nil) -> T {
        let fetchRequest = T.fetchRequest() as! NSFetchRequest<T>
        
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.predicate = predicate
        
        if let fetchedResult = try? self.fetch(fetchRequest), let objectModal = fetchedResult.first {
            return objectModal
        }
        let entity = NSEntityDescription.entity(forEntityName: T.entity().name!, in: self)
        let objectModal = NSManagedObject(entity: entity!, insertInto: self)
        
        return objectModal as! T
    }
}
