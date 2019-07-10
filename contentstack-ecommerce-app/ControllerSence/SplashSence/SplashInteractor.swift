//
//  SplashInteractor.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit
import Contentstack
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
            guard let qResult = queryResult, let result = qResult.getResult() as? [Entry] else {return}
            let backgroundContext = AppDelegate.shared.persistentContainer.newBackgroundContext()
            for entrys in result {
                if let navigation = entrys.object(forKey: "navigation") as? [[AnyHashable: Any]] {
                    var order : Double = 0
                    for navList in navigation {
                        if let categoryDict = (navList["category"] as? [Any])?.first as? [AnyHashable: Any], let uid = categoryDict["uid"] as? String {
                            let entry = APIManger.stack.contentType(withName: "category").entry(withUID: uid)
                            entry.configure(with: categoryDict)
                            let predicate = NSPredicate(format: "uid = %@", entry.uid)
                            let category = backgroundContext.findOrCreate(Category.self, predicate: predicate)
                            category.uid = entry.uid
                            category.order = order
                            category.title = navList["title"] as? String
                            category.desc = entry.object(forKey: "description") as? String
                            order += 1
                            print(category)
                        }
                    }
//                    print(navigation)
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
