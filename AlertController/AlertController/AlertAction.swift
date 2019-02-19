//
//  AlertAction.swift
//  AlertController
//
//  Created by bruce on 2019/1/28.
//  Copyright © 2019 teambition. All rights reserved.
//

import Foundation

let AlertActionEnabledDidChangeNotification = "AlertActionEnabledDidChangeNotification"

open class AlertAction : NSObject, NSCopying {
    open var title: String?
    open var style: AlertAction.Style
    var handler: ((AlertAction) -> Void)?
    open var isEnabled: Bool {
        didSet {
            if (oldValue != isEnabled) {
                NotificationCenter.default.post(name: Notification.Name(rawValue: AlertActionEnabledDidChangeNotification), object: nil)
            }
        }
    }
    open var isSelected: Bool = false
    open var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center
    
    open var leftImage: UIImage?
    open var rightImage: UIImage?
    
    required public init(title: String?, style: AlertAction.Style, handler: ((AlertAction) -> Void)?) {
        self.title = title
        self.style = style
        self.handler = handler
        self.isEnabled = true
    }
    
    open func copy(with zone: NSZone?) -> Any {
        let copy = type(of: self).init(title: title, style: style, handler: handler)
        copy.isEnabled = self.isEnabled
        return copy
    }
}
