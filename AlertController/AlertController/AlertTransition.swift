//
//  AlertTransition.swift
//  AlertController
//
//  Created by bruce on 2019/1/28.
//  Copyright © 2019 teambition. All rights reserved.
//

import Foundation

class AlertTransition: NSObject, UIViewControllerTransitioningDelegate {
    weak var alertController: AlertController?
    
    init(alertController: AlertController?) {
        self.alertController = alertController
    }

    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        alertController?.layoutView(presenting)
        return AlertAnimation(isPresenting: true)
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimation(isPresenting: false)
    }
}
