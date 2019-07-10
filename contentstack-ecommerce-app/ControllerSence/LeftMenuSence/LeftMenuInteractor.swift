//
//  LeftMenuInteractor.swift
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

protocol LeftMenuBusinessLogic
{
  func doCategoryModal(request: LeftMenu.CategoryModal.Request)
}

protocol LeftMenuDataStore
{
  //var name: String { get set }
}

class LeftMenuInteractor: LeftMenuBusinessLogic, LeftMenuDataStore
{
  var presenter: LeftMenuPresentationLogic?
  var worker: LeftMenuWorker?
  //var name: String = ""
  
  // MARK: Do CategoryModal
  
  func doCategoryModal(request: LeftMenu.CategoryModal.Request)
  {
    worker = LeftMenuWorker()
    let response = worker!.fetchCategory(request: request)
    presenter?.show(response: response)
  }
}
