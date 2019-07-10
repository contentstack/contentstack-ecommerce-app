//
//  LeftMenuWorker.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 03/12/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class LeftMenuWorker
{
    func fetchCategory(request: LeftMenu.CategoryModal.Request) -> LeftMenu.CategoryModal.Response
  {
    request.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
    let fetchedResult = try! AppDelegate.shared.persistentContainer.viewContext.fetch( request.fetchRequest)
    return LeftMenu.CategoryModal.Response(categoryArray: fetchedResult)
  }
}
