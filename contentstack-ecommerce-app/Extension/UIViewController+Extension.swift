//
//  UIViewController+Extension.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import Foundation
import UIKit
import ObjectiveC

var observerHandle: UInt8 = 0
var operationHandle: UInt8 = 0
var idHandle: UInt8 = 0

private let swizzling: (UIViewController.Type) -> (Swift.Void) = { viewController in

    let originalSelector = #selector(viewController.viewDidLoad)
    let swizzledSelector = #selector(viewController.cfsViewDidLoad)

    let originalMethod = class_getInstanceMethod(viewController, originalSelector)
    let swizzledMethod = class_getInstanceMethod(viewController, swizzledSelector)

    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}

protocol StoryBoardID: class {}

extension StoryBoardID where Self: UIViewController {
    static var storyBoardID: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryBoardID {
    var idForView: String? {
        get {
            return objc_getAssociatedObject(self, &idHandle) as! String?
        }
        set {
            objc_setAssociatedObject(self, &idHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var observer: [NSObjectProtocol]? {
        get{
            return objc_getAssociatedObject(self, &observerHandle) as! [NSObjectProtocol]?
        }
        set {
            objc_setAssociatedObject(self, &observerHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var operationQueue: OperationQueue? {
        get{
            return objc_getAssociatedObject(self, &operationHandle) as! OperationQueue?
        }
        set {
            objc_setAssociatedObject(self, &operationHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    class func initializ() {
        guard self === UIViewController.self else { return }
        swizzling(self)
    }

    @objc func cfsViewDidLoad() {
        self.cfsViewDidLoad()
        self.updateui()
        let ob = NotificationCenter.default.addObserver(forName: NSNotification.Name("APPTHEME"), object: nil, queue: OperationQueue.main) {[weak self] (notification) in
            guard let slf = self else {return}
            slf.updateui()
//            slf.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppTheme.shared.navigationTintColor]
//            slf.navigationController?.navigationBar.barTintColor = AppTheme.shared.navigationBarColor
//            slf.navigationController?.navigationBar.tintColor = AppTheme.shared.navigationTintColor

        }
        self.observer?.append(ob)
    }
    
    @objc func updateui() {
        
    }
    
    @objc func prepareViewForID(id: String) {
        self.idForView = id
    }
    
    @objc func prepareView(id: Any) {
        
    }
    
    func alertUser (errorMessage: String, completion: (()->Swift.Void)? = nil) {
        let alertView = UIAlertController(title: "", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default) { (_) in
            if let cmp = completion {
                cmp()
            }
        }
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func getViewController() -> UIViewController {
        if let presentViewcontroller = self.presentedViewController {
            return presentViewcontroller.getViewController()
        }
        return self
    }
    
    func cfsDeinit () {
        if let obsr = observer {
            for ob in obsr {
                NotificationCenter.default.removeObserver(ob)
            }
        }
    }
}

extension UINavigationController {
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return self.topViewController!.preferredInterfaceOrientationForPresentation
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.topViewController!.preferredStatusBarStyle
    }
}
