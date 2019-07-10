//
//  SplashRouter.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit

@objc protocol SplashRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol SplashDataPassing
{
  var dataStore: SplashDataStore? { get }
}

class SplashRouter: NSObject, SplashRoutingLogic, SplashDataPassing
{
  weak var viewController: SplashViewController?
  var dataStore: SplashDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: SplashViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: SplashDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
