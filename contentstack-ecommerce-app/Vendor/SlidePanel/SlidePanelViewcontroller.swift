//
//  SlidePanelViewcontrolle.swift
//  ConferenceApp
//
//  Created by Uttam Ukkoji on 07/09/18.
//  Copyright © 2018 Contentstack. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

enum SlidePanelState {
    case centerPanel
    case rightPanel
    case leftPanel
}

protocol VideoPlayerDismissed: class {
    func didDismissVideoPlayer()
}

typealias SlidePanelCompletion = (()->Void)
var ISIPAD = false
var kBottomviewHeight: CGFloat = ISIPAD ? 80.0: 60.0

class SlidePanelViewController: UIViewController {
    
    var currentState: SlidePanelState = .centerPanel
    var leftPanelWidth: CGFloat = UIScreen.main.bounds.width * 0.84
    var rightPanelWidth: CGFloat = UIScreen.main.bounds.width * 0.8
    var statusBarFrame = UIApplication.shared.statusBarFrame
    var bottomViewMinHeight: CGFloat   = kBottomviewHeight
    var shouldTranslate: Bool      = false
    var shouldBounce: Bool      = true
    var shouldSetAlpha: Bool      = false
    var scaleCenterView: CGFloat   = 0.09
    private var startXPostion: CGFloat   = 0
    private var displacement: CGFloat   = 0
    private var lastXPosition: CGFloat   = -1
    private var panDirection: String?
    
    
    var percetage: CGFloat   = 0
    var panalSlideAnimationDuration             = 0.3
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer? = {
        let tap                     = UITapGestureRecognizer(target: self, action: #selector(SlidePanelViewController.closePanel))
        tap.numberOfTapsRequired    = 1
        tap.numberOfTouchesRequired = 1
        tap.delaysTouchesEnded      = true
        tap.delegate                = self
        return tap
    }()
    
    lazy var panGestureRecognizer: UIPanGestureRecognizer? = {
        let pan                     = UIPanGestureRecognizer(target: self, action: #selector(SlidePanelViewController.handlepanGesture(recognizer:)))
        pan.delegate                = self
        return pan
    }()
    
    private var centerViewC: UIViewController?
    var centerViewController: UIViewController? {
        didSet {
            var transform: CGAffineTransform = CGAffineTransform.identity
            let screensize = UIScreen.main.bounds.size
            let windowSize = CGSize(width: screensize.width, height: (screensize.height - (UIApplication.shared.statusBarFrame.height - 20)))
            
            if let centrVC = centerViewC {
                transform = centrVC.view.transform
                centrVC.view.removeFromSuperview()
                centrVC.removeFromParent()
            }
            
            if let newCenterVC = centerViewController {
                centerViewC = newCenterVC
                newCenterVC.view.layer.masksToBounds = true
                newCenterVC.willMove(toParent: self)
                addChild(newCenterVC)
                view.addSubview(newCenterVC.view)
                newCenterVC.didMove(toParent: self)
                newCenterVC.view.frame = CGRect(origin: CGPoint.zero, size: windowSize)
                newCenterVC.view.transform = transform
                newCenterVC.view.addGestureRecognizer(panGestureRecognizer!)
            }
            self.addMenuButton()
        }
    }
    
    var leftViewController: UIViewController? {
        didSet {
            let screensize = UIScreen.main.bounds.size
            let windowSize = CGSize(width: leftPanelWidth, height: (screensize.height - (statusBarFrame.height - 20)))
            
            if let leftVC = leftViewController {
                leftVC.willMove(toParent: self)
                addChild(leftVC)
                view.addSubview(leftVC.view)
                leftVC.didMove(toParent: self)
                leftVC.view.frame = CGRect(origin: CGPoint.zero, size: windowSize)
            }
        }
    }
    
    var rightViewController: UIViewController? {
        didSet {
            let screensize = UIScreen.main.bounds.size
            let windowSize = CGSize(width: UIScreen.main.bounds.width * 0.858, height: (screensize.height - (statusBarFrame.height - 20)))
            
            if let rightVC = rightViewController {
                rightVC.willMove(toParent: self)
                addChild(rightVC)
                view.addSubview(rightVC.view)
                rightVC.didMove(toParent: self)
                rightVC.view.frame = CGRect(origin: CGPoint(x: view.frame.width - windowSize.width, y: 0), size: windowSize)
            }
        }
    }
    
    private func addMenuButton() {
        if let _ = self.leftViewController, let nav = self.centerViewController as? UINavigationController {
            let barbutton = UIBarButtonItem(image: UIImage(named: "menu")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(SlidePanelViewController.openLeftPanel))
//            barbutton.tintColor = UIColor.black
            barbutton.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0);
            nav.topViewController?.navigationItem.leftBarButtonItem = barbutton
        }
        if let _ = self.rightViewController, let nav = self.centerViewController as? UINavigationController {
            let barbutton = UIBarButtonItem(image: UIImage(named: "menu")!, style: UIBarButtonItem.Style.plain, target: self, action: #selector(SlidePanelViewController.openRightPanel))
//            barbutton.tintColor = UIColor.black
            barbutton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20);
            nav.topViewController?.navigationItem.rightBarButtonItem = barbutton
        }
        
    }
    
    override func loadView() {
        super.loadView()
        //let rightView = self.storyboard?.instantiateViewController(withIdentifier: "RightViewController")
        let leftView = self.storyboard?.instantiateViewController(withIdentifier: "LeftViewController")
        self.leftViewController = leftView
        self.centerViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductListNavigation")
        //self.rightViewController = rightView
    }
    
    @objc private func handlepanGesture (recognizer: UIPanGestureRecognizer) {
        
        if ((centerViewController!.isKind(of: UINavigationController.classForCoder()) )
            ) {
            let navig: UINavigationController = centerViewController  as! UINavigationController
            if (navig.viewControllers.count > 1) {
                return
            }
        }
        let transition: CGFloat   = recognizer.translation(in: view).x
        let locationInView: CGFloat   = recognizer.location(in: view).x
        let centerViewFrame: CGRect    = centerViewController!.view.frame
        
        if (recognizer.state == UIGestureRecognizer.State.began) {
            startXPostion = (centerViewController!.view.transform.tx)
            displacement = 0
        }
        
        if (lastXPosition != -1) {
            if (lastXPosition > locationInView) {
                if (panDirection == "RIGHT") {
                    displacement = transition * -1
                    startXPostion = (centerViewController!.view.transform.tx)
                }
                let totalDisplacement = startXPostion + displacement + transition
                if (rightViewController != nil || centerViewFrame.origin.x > 0) {
                    if totalDisplacement > 0 {
                        centerViewTranform((totalDisplacement / leftPanelWidth))
                    }else if totalDisplacement <= -rightPanelWidth {
                        centerViewTranform(-1)
                    }else {
                        if (rightViewController == nil && totalDisplacement < 0 ) {
                            centerViewTranform(0)
                        }else {
                            centerViewTranform(totalDisplacement / rightPanelWidth)
                        }
                    }
                }else {
                    centerViewTranform(0)
                }
                panDirection = "LEFT"
            }else if (lastXPosition < locationInView) {
                if (panDirection == "LEFT") {
                    displacement = transition * -1
                    startXPostion = (centerViewController!.view.transform.tx)
                }
                let totalDisplacement = startXPostion + displacement + transition
                if (leftViewController != nil || centerViewFrame.origin.x < 0) {
                    if totalDisplacement < 0 {
                        centerViewTranform(totalDisplacement / rightPanelWidth)
                    }else if totalDisplacement > leftPanelWidth {
                        centerViewTranform(1)
                    }else {
                        if (leftViewController == nil && totalDisplacement > 0 ) {
                            centerViewTranform(0)
                        }else {
                            centerViewTranform((totalDisplacement / leftPanelWidth))
                        }
                    }
                }else {
                    centerViewTranform(0)
                }
                panDirection = "RIGHT"
            }
            setLeftRightFrame()
        }
        
        lastXPosition = locationInView
        
        if (recognizer.state == UIGestureRecognizer.State.ended || recognizer.state == UIGestureRecognizer.State.cancelled) {
            lastXPosition = -1
            
            if (panDirection == "RIGHT") {
                if (centerViewController!.view.transform.tx / leftPanelWidth > 0.4) {
                    openLeftPanel()
                }else {
                    closeInPanGesture()
                }
            }else {
                if (centerViewController!.view.transform.tx / rightPanelWidth < -0.4) {
                    openRightPanel()
                }else {
                    closeInPanGesture()
                }
            }
        }
    }
    
    private func setLeftRightFrame () {
        let tranformX = centerViewController!.view.transform.tx
        if tranformX > 0 {
            leftViewController?.view.isHidden    = false
            rightViewController?.view.isHidden   = true
            view.backgroundColor                 = leftViewController!.view.backgroundColor
        }else {
            rightViewController?.view.isHidden   = false
            leftViewController?.view.isHidden    = true
            view.backgroundColor                 = rightViewController?.view.backgroundColor
        }
    }
    
    func panelControllerForSlide (_ slidePanel: SlidePanelState) -> UIViewController? {
        if slidePanel == SlidePanelState.leftPanel {
            return leftViewController
        }else if slidePanel == SlidePanelState.rightPanel {
            return rightViewController
        }
        return nil
    }
    
    @objc func closePanel () {
        if let center = self.centerViewController {
            center.view.layer.borderWidth = 0
            closePanelWithCompletion { () -> Void in
                
            }
        }
    }
    
    func closePanelWithCompletion (completion: @escaping SlidePanelCompletion)  {
        let panelContoller: UIViewController? = panelControllerForSlide(currentState)
        if (panelContoller == nil) {
            return
        }
        centerViewController!.view.layer.cornerRadius = 0
        
        UIView.animate(withDuration: panalSlideAnimationDuration, animations: {[weak self] () -> Void in
            self!.centerViewTranform(0)
        }) {[weak self] (_) -> Void in
            self!.leftViewController?.view.isHidden = true
            self!.rightViewController?.view.isHidden = true
            self!.currentState = SlidePanelState.centerPanel
            self!.bounceEffect()
            self!.setUserInteraction(true)
            self!.centerViewController!.view.removeGestureRecognizer(self!.tapGestureRecognizer!)
            self!.setNeedsStatusBarAppearanceUpdate()
            completion()
        }
    }
    
    func openArenaMenu(completion: @escaping SlidePanelCompletion)  {
        UIView.animate(withDuration: 0.6, animations: {[weak self] in
            guard let slf = self else {return}
            slf.view.layoutIfNeeded()
        }) {[weak self] (_) in
            guard let slf = self else {return}
            completion()
            slf.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func closeArenaMenu(completion: @escaping SlidePanelCompletion)  {
        UIView.animate(withDuration: 0.6, animations: {[weak self] in
            guard let slf = self else {return}
            slf.view.layoutIfNeeded()
        }) {[weak self] (_) in
            guard let slf = self else {return}
            completion()
            slf.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @objc func openLeftPanel () {
        setUserInteraction(false)
        centerViewController!.view.addGestureRecognizer(tapGestureRecognizer!)
        openSlide(slidePanel: SlidePanelState.leftPanel) { () -> Void in
            
        }
    }
    
    @objc func openRightPanel () {
        setUserInteraction(false)
        centerViewController!.view.addGestureRecognizer(tapGestureRecognizer!)
        openSlide(slidePanel: SlidePanelState.rightPanel) { () -> Void in
           
        }
    }
    
    private func openSlide(slidePanel: SlidePanelState, completion: @escaping SlidePanelCompletion) {
        let panelContoller: UIViewController? = panelControllerForSlide(slidePanel)
        if (panelContoller == nil) {
            return
        }
        
        var percetage: CGFloat = 0
        
        if (slidePanel == SlidePanelState.leftPanel) {
            percetage = 1
        }else {
            centerViewController!.view.layer.borderWidth = 1
            percetage = -1
        }
        if (slidePanel == SlidePanelState.leftPanel) {
            leftViewController?.view.isHidden   = false
            rightViewController?.view.isHidden  = true
        }else {
            rightViewController?.view.isHidden  = false
            leftViewController?.view.isHidden   = true
        }
        centerViewController!.view.layer.cornerRadius = 8
       
        UIView.animate(withDuration: panalSlideAnimationDuration, animations: {[weak self] in
            self!.centerViewTranform(percetage)
        }) {[weak self] (_) in
            self?.currentState = slidePanel
            self!.bounceEffect()
            self!.setUserInteraction(false)
            self!.centerViewController!.view.addGestureRecognizer(self!.tapGestureRecognizer!)
            completion()
            self!.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private func closeInPanGesture () {
        var centerViewFrame: CGRect = centerViewController!.view.frame
        centerViewFrame.origin.x = 0
        centerViewController!.view.layer.cornerRadius = 0
        UIView.animate(withDuration: panalSlideAnimationDuration, animations: {[weak self] () -> Void in
            self!.centerViewTranform(0)
            self!.setUserInteraction(true)
            self!.centerViewController!.view.removeGestureRecognizer(self!.tapGestureRecognizer!)
            self!.currentState = .centerPanel
        }) {[weak self] (_) -> Void in
            self!.bounceEffect()
            self!.leftViewController?.view.isHidden = true
            self!.rightViewController?.view.isHidden = true
            self!.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private func bounceEffect () {
        if shouldBounce == false {
            return
        }
        let animateBounceDuration = 0.3
        switch currentState {
        case .leftPanel:
            UIView.animate(withDuration: animateBounceDuration, animations: { [weak self] () -> Void in
                self!.centerViewTranform(0.9)
                }, completion: {[weak self] (_) in
                    UIView.animate(withDuration: animateBounceDuration, animations: { [weak self] () -> Void in
                        self!.centerViewTranform(1)
                    })
            })
        case .rightPanel:
            UIView.animate(withDuration: animateBounceDuration, animations: { [weak self] () -> Void in
                self!.centerViewTranform(-0.9)
                }, completion: {[weak self] (_) in
                    UIView.animate(withDuration: animateBounceDuration, animations: { [weak self] () -> Void in
                        self!.centerViewTranform(-1)
                    })
            })
        case .centerPanel:
            UIView.animate(withDuration: animateBounceDuration, animations: { [weak self] () -> Void in
                self!.centerViewTranform(0)
                }, completion: {[weak self] (_) in
                    UIView.animate(withDuration: animateBounceDuration, animations: { [weak self] () -> Void in
                        self!.centerViewTranform(0)
                    })
            })
        }
    }
    
    private func setUserInteraction (_ interaction: Bool) {
        if (centerViewController!.isKind(of: UINavigationController.classForCoder()) == true) {
            let nvg: UINavigationController = centerViewController as! UINavigationController
            for viewController in nvg.viewControllers {
                (viewController).view.isUserInteractionEnabled = interaction
                viewController.view.setNeedsUpdateConstraints()
                
            }
        }
    }
    
    func centerViewTranform(_ percentage: CGFloat) {
        if percentage == 0 {
            centerViewController!.view.layer.cornerRadius = 0
        }else {
            centerViewController!.view.layer.cornerRadius = 8
        }
        if percentage < 0 {
            view.backgroundColor = UIColor.white
            centerViewController!.view.layer.borderWidth = 1
        }else {
            if leftViewController!.view.isHidden == false {
                view.backgroundColor = UIColor.white
            }
        }
        let panalWidth = percentage > 0 ? leftPanelWidth-20: rightPanelWidth
        let translate = CGAffineTransform.identity.translatedBy(x: (panalWidth * percentage), y: 0)
        let scalePoint =  shouldTranslate ?  1 - (scaleCenterView * abs(percentage)): 1
        centerViewController?.view.transform = translate.scaledBy(x: scalePoint, y: scalePoint)
        
        if shouldSetAlpha {
            centerViewController!.view.alpha = 1 - (scaleCenterView * abs(percentage))
        }
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return UIInterfaceOrientation.portrait
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        switch currentState {
        case .centerPanel:
//            if let nav = self.centerViewController as? UINavigationController {
//                if let topVC = nav.topViewController {
//                    return topVC.preferredStatusBarStyle
//                }
//            }
            return .lightContent
        case .leftPanel:
            return .default
        case .rightPanel:
            return .default
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .fade
    }
}

extension SlidePanelViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}

