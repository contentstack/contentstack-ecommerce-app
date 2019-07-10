//
//  LeftMenuModels.swift
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
import CoreData
enum LeftMenu
{
  // MARK: Use cases
  
  enum CategoryModal
  {
    struct Request
    {
        let fetchRequest = Category.categoryFetchRequest()
        
    }
    struct Response
    {
        let categoryArray :[Category]
    }
    struct ViewModel
    {
    }
  }
}
