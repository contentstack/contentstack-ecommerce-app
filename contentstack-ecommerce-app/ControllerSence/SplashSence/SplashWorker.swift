//
//  SplashWorker.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit
import Contentstack
class SplashWorker
{
    func performCategoryFetch(request: Splash.Request, onCompletion: @escaping ((QueryResult?, Error?)-> (Swift.Void)))
    {
        request.categoryQuery.includeReferenceField(withKey: ["navigation.category"])
        request.categoryQuery.find { (responseType, queryResult, error) in
            onCompletion(queryResult, error)
        }
    }
}
