//
//  APIManager.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 13/08/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import Contentstack
class StackConfig {
    static var APIKey           = "blt11467371f44f3c8c"
    static var AccessToken      = "blt1d60be58e6053763"
    static var EnvironmentName  = "development"
    static var _config : Config {
        get {
            let config = Config()
//            config.host = "stag-cdn.contentstack.io"
            return config
        }
    }
}

enum APIManger {
    static var stack : Stack = Contentstack.stack(withAPIKey: StackConfig.APIKey, accessToken: StackConfig.AccessToken, environmentName: StackConfig.EnvironmentName, config:StackConfig._config)
    
}
