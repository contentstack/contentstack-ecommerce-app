//
//  SplashPresenter.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit

protocol SplashPresentationLogic
{
  func presentCategoryModal()
}

class SplashPresenter: SplashPresentationLogic
{
  weak var viewController: SplashDisplayLogic?
  
  // MARK: Do CategoryModal
  
  func presentCategoryModal()
  {
    viewController?.showhomeview()
  }
}
