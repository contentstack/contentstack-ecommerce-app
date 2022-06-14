//
//  ProductListSencePresenter.swift
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

protocol ProductListSencePresentationLogic
{
    func loadProductList(request: ProductListSence.Products.Request)
    func showProductList(response: ProductListSence.Products.Response)
    func showProductDetails()
}

class ProductListSencePresenter: ProductListSencePresentationLogic
{
  weak var viewController: ProductListSenceDisplayLogic?
  
  // MARK: Do something
  
    func loadProductList(request: ProductListSence.Products.Request) {
        viewController?.getProducts(request: request)
    }
    
    func showProductList(response: ProductListSence.Products.Response) {
        viewController?.reloadWithData(response: response)
    }
    
    func showProductDetails() {
        viewController?.showProductDetails()
    }
}