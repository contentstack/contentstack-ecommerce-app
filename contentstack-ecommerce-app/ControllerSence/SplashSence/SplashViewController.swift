//
//  SplashViewController.swift
//  contentstack-ecommerce-app
//
//  Created by Uttam Ukkoji on 30/11/18.
//  Copyright (c) 2018 Contentstack. All rights reserved.


import UIKit

protocol SplashDisplayLogic: class
{
    func showhomeview()
}

class SplashViewController: UIViewController, SplashDisplayLogic
{
    var interactor: SplashBusinessLogic?
    var router: (NSObjectProtocol & SplashRoutingLogic & SplashDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = SplashInteractor()
        let presenter = SplashPresenter()
        let router = SplashRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        getCategory()
    }
    
    // MARK: Do CategoryModal
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func getCategory()
    {
        AppDelegate.shared.persistentContainer.viewContext.deleteAll(Category.self)
        let request = Splash.Request()
        interactor?.getCategory(request: request)
    }
    
    func showhomeview() {
        let storyBoard = UIStoryboard(name: "SlidePanel", bundle: nil)
        AppDelegate.shared.window?.rootViewController = storyBoard.instantiateInitialViewController()
    }
}

