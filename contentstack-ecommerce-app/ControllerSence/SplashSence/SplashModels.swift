//
//  SplashModels.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit

enum Splash
{
  // MARK: Use cases
 
    struct Request
    {
        let categoryQuery = APIManger.stack.contentType(uid: "header").entry().query()
    }
    struct Response
    {
        
    }
    struct ViewModel
    {
    }
}
