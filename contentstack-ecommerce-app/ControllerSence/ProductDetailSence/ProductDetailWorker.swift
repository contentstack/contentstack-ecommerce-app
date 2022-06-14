//
//  ProductDetailWorker.swift
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

class ProductDetailWorker
{
    func fetchProduct(request: ProductDetail.Request) -> ProductDetail.Response
    {
        let fetchRequest = request.fetchRequet
        fetchRequest.predicate = NSPredicate(format: "uid = %@", request.productID)
        var response = ProductDetail.Response()
        if let fetchResult = try? AppDelegate.shared.persistentContainer.viewContext.fetch(fetchRequest) {
            
            if let result = fetchResult.first {
                response.product = result
            }
        }
        return response
    }
}
