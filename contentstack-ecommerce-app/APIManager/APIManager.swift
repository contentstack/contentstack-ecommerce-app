//
//  APIManager.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import ContentstackSwift
class StackConfig {
    static var APIKey           = "blt11467371f44f3c8c"
    static var DeliveryToken      = "blt1d60be58e6053763"
    static var EnvironmentName  = "development"
    
}

enum APIManger {
    static var stack : Stack = Contentstack.stack(apiKey: StackConfig.APIKey, deliveryToken: StackConfig.DeliveryToken, environment: StackConfig.EnvironmentName)
    
}
