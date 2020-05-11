//
//  SplashInteractor.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit
import ContentstackSwift
protocol SplashBusinessLogic
{
  func getCategory(request: Splash.Request)
}

protocol SplashDataStore
{
  //var name: String { get set }
}

class SplashInteractor: SplashBusinessLogic, SplashDataStore
{
    func getCategory(request: Splash.Request) {
        worker = SplashWorker()
        worker?.performCategoryFetch(request: request, onCompletion: { (queryResult, error) -> (Void) in
            guard let qResult = queryResult else {return}
            let result = qResult.items
            let backgroundContext = AppDelegate.shared.persistentContainer.newBackgroundContext()
            for entrys in result {
                if let navigation = entrys.fields?["navigation"] as? [[AnyHashable: Any]] {
                    var order : Double = 0
                    for navList in navigation {
                        if let entry = (navList["category"] as? [EntryModel])?.first {
                            let predicate = NSPredicate(format: "uid = %@", entry.uid)
                            let category = backgroundContext.findOrCreate(Category.self, predicate: predicate)
                            category.uid = entry.uid
                            category.order = order
                            category.title = navList["title"] as? String
                            if let desc = entry.fields?["description"] as? String {
                                category.desc = desc
                            }
                            order += 1
                        }
                    }
                }
            }
            do {
                try backgroundContext.save()
            }catch {
                
            }
            self.presenter?.presentCategoryModal()

        })
        
    }
    
  var presenter: SplashPresentationLogic?
  var worker: SplashWorker?
  //var name: String = ""
  
  // MARK: Do CategoryModal
  
  func doCategoryModal(request: Splash.Request)
  {
   
  }
}
