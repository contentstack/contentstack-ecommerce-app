//
//  SplashWorker.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit
import ContentstackSwift
class SplashWorker
{
    func performCategoryFetch(request: Splash.Request, onCompletion: @escaping ((ContentstackResponse<EntryModel>?, Error?)-> (Swift.Void)))
    {
        request.categoryQuery
            .includeReference(with: ["navigation.category"])
            .find { (result: Result<ContentstackResponse<EntryModel>, Error>, response: ResponseType) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        onCompletion(response, nil)
                    case .failure(let error):
                        onCompletion(nil, error)
                    }
                }
            }
    }
}
