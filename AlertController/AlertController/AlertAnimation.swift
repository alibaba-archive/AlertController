//
//  AlertAnimation.swift
//  AlertController
//
//  Created by bruce on 2019/1/28.
//  Copyright © 2019 teambition. All rights reserved.
//

import Foundation

open class AlertAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if isPresenting {
            return 0.15
        } else {
            return 0.25
        }
    }
    
    open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentAnimateTransition(transitionContext)
        } else {
            dismissAnimateTransition(transitionContext)
        }
    }
    
    func presentAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! AlertController
        let containerView = transitionContext.containerView
        alertController.overlayView.alpha = 0.0

        if alertController.isAlert {
            alertPresentAnimaion(alertController, containerView: containerView, transitionContext: transitionContext)
        } else {
            actionSheetPresentAnimaion(alertController, containerView: containerView, transitionContext: transitionContext)
        }
    }
    
    // MARK: - Alert Present
    private func alertPresentAnimaion(_ alertController: AlertController, containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        alertController.alertView.alpha = 0.0
        alertController.alertView.center = alertController.view.center
        alertController.alertView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: 0.10,
                       delay: 0,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        alertController.overlayView.alpha = 1.0
                        alertController.alertView.alpha = 0.6
                        alertController.alertView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                        },
                       completion: { finished in
                        UIView.animate(withDuration: 0.05,
                                       delay: 0,
                                       options: UIView.AnimationOptions(rawValue: 7 << 16),
                                       animations: {
                                        alertController.alertView.alpha = 1.0
                                        alertController.alertView.transform = CGAffineTransform.identity
                        },
                                       completion: { finished in
                                        if (finished) {
                                            transitionContext.completeTransition(true)
                                        }
                        })
        })
    }
    
    // MARK: - Actionsheet Present
    private func actionSheetPresentAnimaion(_ alertController: AlertController, containerView: UIView, transitionContext: UIViewControllerContextTransitioning) {
        alertController.alertView.transform = CGAffineTransform(translationX: 0, y: alertController.alertView.frame.height)
        containerView.addSubview(alertController.view)
        
        UIView.animate(withDuration: 0.15,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: 7 << 16),
                       animations: {
                        alertController.overlayView.alpha = 1.0
                            alertController.alertView.transform = CGAffineTransform(translationX: 0, y: 0)
        },
                       completion: { finished in
                        alertController.alertView.transform = CGAffineTransform.identity
                        transitionContext.completeTransition(true)
        })
    }
    
    // MARK: - ActionSheet animation
    
    func dismissAnimateTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AlertController
        
        if alertController.isAlert {
            alertDismissAnimation(alertController, transitionContext: transitionContext)
        } else {
            actionSheetDismissAnimation(alertController, transitionContext: transitionContext)
        }
    }
    
    private func alertDismissAnimation(_ alertController: AlertController, transitionContext: UIViewControllerContextTransitioning) {
        let alertController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! AlertController
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        alertController.overlayView.alpha = 0.0
                        alertController.alertView.alpha = 0.0
                        alertController.alertView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { finished in
                        transitionContext.completeTransition(true)
        })
    }
    
    private func actionSheetDismissAnimation(_ alertController: AlertController, transitionContext: UIViewControllerContextTransitioning) {
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
                       animations: {
                        alertController.overlayView.alpha = 0.0
                        alertController.containerView.transform = CGAffineTransform(translationX: 0, y: alertController.alertView.frame.height)
        },
                       completion: { finished in
                        transitionContext.completeTransition(true)
        })
    }
}
