//
//  AlertController.swift
//  AlertController
//
//  Created by bruce on 2019/1/28.
//  Copyright © 2019 teambition. All rights reserved.
//

import UIKit

open class AlertController: UIViewController {
    
    // Message
    open var message: String?
    
    // AlertController Style
    fileprivate(set) var preferredStyle: AlertController.Style?
    
    // OverlayView
    var overlayView = UIView()
    open var overlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
    
    // Pressed to dimiss
    private var dimmingView = UIView()
    open var isEnableTapDimmingViewToDimissed: Bool = false
    open var dimissAction: (() -> Void)?
    
    // ContainerView
    var containerView = UIView()
    fileprivate var containerViewBottomSpaceConstraint: NSLayoutConstraint?
    
    // AlertView
    open var alertView = UIView()
    open var alertViewBackgroundColor = UIColor.white
    // max height for alert view
    // if zero, max height will be 70% of screen height
    open var alertViewMaxHeight: CGFloat = 0
    fileprivate var alertViewWidth: CGFloat = 270.0
    fileprivate var alertViewHeightConstraint: NSLayoutConstraint?
    fileprivate var alertViewPadding: CGFloat = 16.0
    fileprivate var innerContentWidth: CGFloat = 270.0
    fileprivate var actionSheetBottomSafeHeight: CGFloat = 0
    fileprivate var actionSheetTopSafeHeight: CGFloat = 0
    
    // TextAreaScrollView
    fileprivate var textAreaScrollView = UIScrollView()
    fileprivate var textAreaHeight: CGFloat = 0
    
    // TextAreaView
    fileprivate var textAreaView = UIView()
    
    // TextContainer
    fileprivate var textContainer = UIView()
    fileprivate var textContainerHeightConstraint: NSLayoutConstraint?
    
    // TitleLabel
    open var titleLabel = UILabel()
    open var titleFont = UIFont.boldSystemFont(ofSize: 16)
    open var titleTextColor = UIColor(red:56/255, green:56/255, blue:56/255, alpha:1.0)
    
    // MessageLabel
    open var messageLabel = UILabel()
    open var messageFont = UIFont.systemFont(ofSize: 12)
    open var messageTextColor = UIColor(red:128/255, green:128/255, blue:128/255, alpha:1.0)
    
    // TextFieldContainerView
    open var textFieldContainerView = UIView()
    open var textFieldBorderColor = UIColor(red: 203.0/255, green: 203.0/255, blue: 203.0/255, alpha: 1.0)
    
    // Seperator Color
    open var seperatorColor = UIColor(red:230/255, green:230/255, blue:230/255, alpha:1.0)
    
    // TextFields
    open var textFields: [UITextField]?
    fileprivate let textFieldHeight: CGFloat = 40.0
    open var textFieldBackgroundColor = UIColor.white
    fileprivate let textFieldCornerRadius: CGFloat = 4.0
    
    // ButtonAreaScrollView
    fileprivate var buttonAreaScrollView = UIScrollView()
    fileprivate var buttonAreaScrollViewHeightConstraint: NSLayoutConstraint?
    fileprivate var buttonAreaHeight: CGFloat = 0
    
    // ButtonAreaView
    fileprivate var buttonAreaView = UIView()
    
    // ButtonContainer
    fileprivate var buttonContainer = UIView()
    fileprivate var buttonContainerHeightConstraint: NSLayoutConstraint?
    fileprivate let buttonHeight: CGFloat = 56.0
    fileprivate var buttonMargin: CGFloat = 0
    
    // Actions
    open fileprivate(set) var actions: [AlertAction] = []
    
    open var isAlert: Bool { // alert style
        return preferredStyle == .alert
    }
    
    // Buttons
    open var buttons = [UIButton]()
    open var buttonFont: [AlertAction.Style : UIFont] = [
        .default : .systemFont(ofSize: 16),
        .cancel : .systemFont(ofSize: 16),
        .destructive : .systemFont(ofSize: 16)
    ]
    open var buttonTextColor: [AlertAction.Style : UIColor] = [
        .default : UIColor(red:56/255, green:56/255, blue:56/255, alpha:1),
        .cancel : UIColor(red:128/255, green:128/255, blue:128/255, alpha:1),
        .destructive : UIColor(red:255/255, green:79/255, blue:62/255, alpha:1)
    ]
    open var buttonBackgroundColor: [AlertAction.Style: UIColor] = [
        .default : .white,
        .cancel : UIColor(red:250/255, green:250/255, blue:250/255, alpha:1),
        .destructive : .white
    ]
    open var buttonBackgroundColorHighlighted: [AlertAction.Style : UIColor] = [
        .default : UIColor(red: 255, green: 255, blue: 255, alpha: 0.3),
        .cancel  : UIColor(red:250/255, green:250/255, blue:250/255, alpha: 0.3),
        .destructive  : UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)
    ]
    open var buttonSelectedColor: UIColor = UIColor(red:61/255, green:168/255, blue:245/255, alpha:1)
    open var checkmarkTrailing: CGFloat = 16

    fileprivate var keyboardHeight: CGFloat = 0
    fileprivate var cancelButtonTag = 0
    fileprivate var layoutFlag = false
    
    fileprivate lazy var alertTransition: AlertTransition = {
        let alertTransition = AlertTransition(alertController: self)
        return alertTransition
    }()
    
    // Initializer
    public convenience init(title: String?, message: String?, preferredStyle: AlertController.Style) {
        self.init(nibName: nil, bundle: nil)
        
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom
        view.tintColor = buttonSelectedColor
        
        // NotificationCenter
        NotificationCenter.default.addObserver(self, selector: #selector(AlertController.handleAlertActionEnabledDidChangeNotification(_:)), name: NSNotification.Name(rawValue: AlertActionEnabledDidChangeNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AlertController.handleKeyboardWillShowNotification(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AlertController.handleKeyboardWillHideNotification(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.transitioningDelegate = alertTransition
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        layoutView(self.presentingViewController)
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) -> Void in
            self.layoutView(self.presentingViewController, isNeededLayout: true)
        }) { (_) -> Void in
        }
    }
    
    open func layoutView(_ presenting: UIViewController?, isNeededLayout: Bool = false) {
        if !isNeededLayout {
            guard !layoutFlag else {
                return
            }
            layoutFlag = true
        }
        if let presentingViewController = presenting {
            if #available(iOS 11.0, *) {
                actionSheetBottomSafeHeight = presentingViewController.view.safeAreaInsets.bottom
                actionSheetTopSafeHeight = presentingViewController.view.safeAreaInsets.top
            } 
        }
        
        // Screen Size
        let screenSize = UIScreen.main.bounds.size//presenting != nil ? presenting!.view.bounds.size : UIScreen.main.bounds.size
        
        // variable for ActionSheet
        if !isAlert {
            alertViewWidth =  screenSize.width
            innerContentWidth = (screenSize.height > screenSize.width) ? screenSize.width : screenSize.height
        }
        
        // self.view
        self.view.frame.size = screenSize
        
        // OverlayView
        self.view.addSubview(overlayView)
        
        // ContainerView
        self.view.addSubview(containerView)
        
        // dimmingView
        self.view.addSubview(dimmingView)
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTapGesture(_:)))
        dimmingView.addGestureRecognizer(tapGestureRecognizer)
        isEnableTapDimmingViewToDimissed = !isAlert
        
        // AlertView
        containerView.addSubview(alertView)
        
        // TextAreaScrollView
        alertView.addSubview(textAreaScrollView)
        
        // TextAreaView
        textAreaScrollView.addSubview(textAreaView)
        
        // TextContainer
        textAreaView.addSubview(textContainer)
        
        // ButtonAreaScrollView
        alertView.addSubview(buttonAreaScrollView)
        
        // ButtonAreaView
        buttonAreaScrollView.addSubview(buttonAreaView)
        
        // ButtonContainer
        buttonAreaView.addSubview(buttonContainer)
        
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        textAreaScrollView.translatesAutoresizingMaskIntoConstraints = false
        textAreaView.translatesAutoresizingMaskIntoConstraints = false
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonAreaScrollView.translatesAutoresizingMaskIntoConstraints = false
        buttonAreaView.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // self.view
        let overlayViewTopSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let overlayViewRightSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0)
        let overlayViewLeftSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0)
        let overlayViewBottomSpaceConstraint = NSLayoutConstraint(item: overlayView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let containerViewTopSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let containerViewRightSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0)
        let containerViewLeftSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0)
        
        containerViewBottomSpaceConstraint = NSLayoutConstraint(item: containerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([overlayViewTopSpaceConstraint, overlayViewRightSpaceConstraint, overlayViewLeftSpaceConstraint, overlayViewBottomSpaceConstraint, containerViewTopSpaceConstraint, containerViewRightSpaceConstraint, containerViewLeftSpaceConstraint, containerViewBottomSpaceConstraint!])
        
        if isAlert {
            // ContainerView
            let alertViewCenterXConstraint = NSLayoutConstraint(item: alertView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0)
            let alertViewCenterYConstraint = NSLayoutConstraint(item: alertView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1.0, constant: 0)
            containerView.addConstraints([alertViewCenterXConstraint, alertViewCenterYConstraint])
            
            // AlertView
            let alertViewWidthConstraint = NSLayoutConstraint(item: alertView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: alertViewWidth)
            alertViewHeightConstraint = NSLayoutConstraint(item: alertView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1000)
            alertView.addConstraints([alertViewWidthConstraint, alertViewHeightConstraint!])
            
        } else {
            // ContainerView
            let alertViewCenterXConstraint = NSLayoutConstraint(item: alertView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1.0, constant: 0)
            let alertViewBottomSpaceConstraint = NSLayoutConstraint(item: alertView, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0)

            let alertViewWidthConstraint = NSLayoutConstraint(item: alertView, attribute: .width, relatedBy: .equal, toItem: containerView, attribute: .width, multiplier: 1.0, constant: 0)
            containerView.addConstraints([alertViewCenterXConstraint, alertViewBottomSpaceConstraint, alertViewWidthConstraint])
            
            // AlertView
            alertViewHeightConstraint = NSLayoutConstraint(item: alertView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 1000.0)
            alertView.addConstraint(alertViewHeightConstraint!)
            
            // dimmingView
            view.addSubview(dimmingView)
            view.addConstraint(NSLayoutConstraint(item: dimmingView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: dimmingView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: dimmingView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0))
            view.addConstraint(NSLayoutConstraint(item: dimmingView, attribute: .bottom, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: 0))
        }
        
        // AlertView
        let textAreaScrollViewTopSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .top, relatedBy: .equal, toItem: alertView, attribute: .top, multiplier: 1.0, constant: 0)
        let textAreaScrollViewRightSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0)
        let textAreaScrollViewLeftSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0)
        let textAreaScrollViewBottomSpaceConstraint = NSLayoutConstraint(item: textAreaScrollView, attribute: .bottom, relatedBy: .equal, toItem: buttonAreaScrollView, attribute: .top, multiplier: 1.0, constant: 0)
        let buttonAreaScrollViewRightSpaceConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .right, relatedBy: .equal, toItem: alertView, attribute: .right, multiplier: 1.0, constant: 0)
        let buttonAreaScrollViewLeftSpaceConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .left, relatedBy: .equal, toItem: alertView, attribute: .left, multiplier: 1.0, constant: 0)
        let buttonAreaScrollViewBottomSpaceConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .bottom, relatedBy: .equal, toItem: alertView, attribute: .bottom, multiplier: 1.0, constant: isAlert ? 0 : -actionSheetBottomSafeHeight)
        
        alertView.addConstraints([textAreaScrollViewTopSpaceConstraint, textAreaScrollViewRightSpaceConstraint, textAreaScrollViewLeftSpaceConstraint, textAreaScrollViewBottomSpaceConstraint, buttonAreaScrollViewRightSpaceConstraint, buttonAreaScrollViewLeftSpaceConstraint, buttonAreaScrollViewBottomSpaceConstraint])
        
        // TextAreaScrollView
        let textAreaViewTopSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .top, relatedBy: .equal, toItem: textAreaScrollView, attribute: .top, multiplier: 1.0, constant: 0)
        let textAreaViewRightSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .right, relatedBy: .equal, toItem: textAreaScrollView, attribute: .right, multiplier: 1.0, constant: 0)
        let textAreaViewLeftSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .left, relatedBy: .equal, toItem: textAreaScrollView, attribute: .left, multiplier: 1.0, constant: 0)
        let textAreaViewBottomSpaceConstraint = NSLayoutConstraint(item: textAreaView, attribute: .bottom, relatedBy: .equal, toItem: textAreaScrollView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let textAreaViewWidthConstraint = NSLayoutConstraint(item: textAreaView, attribute: .width, relatedBy: .equal, toItem: textAreaScrollView, attribute: .width, multiplier: 1.0, constant: 0)
        textAreaScrollView.addConstraints([textAreaViewTopSpaceConstraint, textAreaViewRightSpaceConstraint, textAreaViewLeftSpaceConstraint, textAreaViewBottomSpaceConstraint, textAreaViewWidthConstraint])
        
        // TextArea
        let textAreaViewHeightConstraint = NSLayoutConstraint(item: textAreaView, attribute: .height, relatedBy: .equal, toItem: textContainer, attribute: .height, multiplier: 1.0, constant: 0)
        let textContainerTopSpaceConstraint = NSLayoutConstraint(item: textContainer, attribute: .top, relatedBy: .equal, toItem: textAreaView, attribute: .top, multiplier: 1.0, constant: 0)
        let textContainerCenterXConstraint = NSLayoutConstraint(item: textContainer, attribute: .centerX, relatedBy: .equal, toItem: textAreaView, attribute: .centerX, multiplier: 1.0, constant: 0)
        textAreaView.addConstraints([textAreaViewHeightConstraint, textContainerTopSpaceConstraint, textContainerCenterXConstraint])
        
        // TextContainer
        let textContainerWidthConstraint = NSLayoutConstraint(item: textContainer, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: innerContentWidth)
        textContainerHeightConstraint = NSLayoutConstraint(item: textContainer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)
        textContainer.addConstraints([textContainerWidthConstraint, textContainerHeightConstraint!])
        textContainer.backgroundColor = .white
        
        // ButtonAreaScrollView
        buttonAreaScrollViewHeightConstraint = NSLayoutConstraint(item: buttonAreaScrollView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)
        let buttonAreaViewTopSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .top, relatedBy: .equal, toItem: buttonAreaScrollView, attribute: .top, multiplier: 1.0, constant: 0)
        let buttonAreaViewRightSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .right, relatedBy: .equal, toItem: buttonAreaScrollView, attribute: .right, multiplier: 1.0, constant: 0)
        let buttonAreaViewLeftSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .left, relatedBy: .equal, toItem: buttonAreaScrollView, attribute: .left, multiplier: 1.0, constant: 0)
        let buttonAreaViewBottomSpaceConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .bottom, relatedBy: .equal, toItem: buttonAreaScrollView, attribute: .bottom, multiplier: 1.0, constant: 0)
        let buttonAreaViewWidthConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .width, relatedBy: .equal, toItem: buttonAreaScrollView, attribute: .width, multiplier: 1.0, constant: 0)
        buttonAreaScrollView.addConstraints([buttonAreaScrollViewHeightConstraint!, buttonAreaViewTopSpaceConstraint, buttonAreaViewRightSpaceConstraint, buttonAreaViewLeftSpaceConstraint, buttonAreaViewBottomSpaceConstraint, buttonAreaViewWidthConstraint])
        
        // ButtonArea
        let buttonAreaViewHeightConstraint = NSLayoutConstraint(item: buttonAreaView, attribute: .height, relatedBy: .equal, toItem: buttonContainer, attribute: .height, multiplier: 1.0, constant: 0)
        let buttonContainerTopSpaceConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .top, relatedBy: .equal, toItem: buttonAreaView, attribute: .top, multiplier: 1.0, constant: 0)
        let buttonContainerCenterXConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .centerX, relatedBy: .equal, toItem: buttonAreaView, attribute: .centerX, multiplier: 1.0, constant: 0)
        buttonAreaView.addConstraints([buttonAreaViewHeightConstraint, buttonContainerTopSpaceConstraint, buttonContainerCenterXConstraint])
        
        // ButtonContainer
        let buttonContainerWidthConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: innerContentWidth)
        buttonContainerHeightConstraint = NSLayoutConstraint(item: buttonContainer, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 0)
        buttonContainer.addConstraints([buttonContainerWidthConstraint, buttonContainerHeightConstraint!])
        
        // Layout & Color Settings
        overlayView.backgroundColor = overlayColor
        alertView.backgroundColor = .white
        
        // TextArea Layout
        let hasTitle: Bool = title != nil && title != ""
        let hasMessage: Bool = message != nil && message != ""
        let hasTextField: Bool = textFields != nil && !textFields!.isEmpty
        
        var textAreaPositionY: CGFloat = alertViewPadding
        
        // TitleLabel
        if hasTitle {
            let titleWidth = innerContentWidth - alertViewPadding * 2
            titleLabel.frame.size = CGSize(width: titleWidth, height: 0)
            titleLabel.numberOfLines = 0
            titleLabel.textAlignment = .center
            titleLabel.font = titleFont
            titleLabel.textColor = titleTextColor
            titleLabel.text = title
            titleLabel.sizeToFit()
            titleLabel.frame = CGRect(x: alertViewPadding, y: alertViewPadding, width: titleWidth, height: titleLabel.frame.height)
            textContainer.addSubview(titleLabel)
            textAreaPositionY += titleLabel.frame.height
            if hasMessage {
                textAreaPositionY += 4.0
            } else {
                textAreaPositionY += alertViewPadding
            }
        }
        
        // messageLabel
        if hasMessage {
            let messageWidth = innerContentWidth - alertViewPadding * 2
            messageLabel.frame.size = CGSize(width: messageWidth, height: 0)
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = .center
            messageLabel.font = hasTitle ? messageFont : titleFont
            messageLabel.textColor = hasTitle ? messageTextColor : titleTextColor
            messageLabel.text = message
            messageLabel.sizeToFit()
            messageLabel.frame = CGRect(x: alertViewPadding, y: textAreaPositionY, width: messageWidth, height: messageLabel.frame.height)
            textContainer.addSubview(messageLabel)
            textAreaPositionY += messageLabel.frame.height + alertViewPadding
        }
        
        if hasTitle || hasMessage {
            buttonContainer.setTopSeparator(with: seperatorColor)
        }
        
        // TextFieldContainerView
        if hasTextField {
            if hasTitle || hasMessage {
                textAreaPositionY += 5.0
            }
            
            textFieldContainerView.backgroundColor = textFieldBackgroundColor
            textFieldContainerView.layer.masksToBounds = true
            textFieldContainerView.layer.cornerRadius = textFieldCornerRadius
            textFieldContainerView.layer.borderWidth = 0.5
            textFieldContainerView.layer.borderColor = seperatorColor.cgColor
            textContainer.addSubview(textFieldContainerView)
            
            var textFieldContainerHeight: CGFloat = 0
            
            // TextFields
            for (_, textField) in textFields!.enumerated() {
                textField.frame = CGRect(x: 10, y: textFieldContainerHeight, width: innerContentWidth - alertViewPadding * 2 - 20, height: textFieldHeight)
                textFieldContainerHeight += textField.frame.height + 0.5
            }
            
            textFieldContainerHeight -= 0.5
            textFieldContainerView.frame = CGRect(x: alertViewPadding, y: textAreaPositionY, width: innerContentWidth - alertViewPadding * 2, height: textFieldContainerHeight)
            textAreaPositionY += textFieldContainerHeight + alertViewPadding
        }
        
        if !hasTitle && !hasMessage && !hasTextField {
            textAreaPositionY = 0
        }
        
        // TextAreaScrollView
        textAreaHeight = textAreaPositionY
        textAreaScrollView.contentSize = CGSize(width: alertViewWidth, height: textAreaHeight)
        textContainerHeightConstraint?.constant = textAreaHeight
        
        // ButtonArea Layout
        var buttonAreaPositionY: CGFloat = buttonMargin
        
        // Buttons
        if isAlert && buttons.count <= 2 {
            if buttons.count == 1 {
                buttons[0].setBackgroundImage(UIColor.white.toImage(), for: .normal)
                buttons[0].setBackgroundImage(UIColor(red: 255, green: 255, blue: 255, alpha: 0.3).toImage(), for: .highlighted)
                buttons[0].setTitleColor(buttonSelectedColor, for: .normal)
                buttons[0].frame = CGRect(x: buttonMargin, y: buttonAreaPositionY, width: innerContentWidth, height: buttonHeight)
                buttonAreaPositionY += buttonHeight
            } else {
                let buttonWidth = (innerContentWidth - buttonMargin) / 2
                var buttonPositionX: CGFloat = 0
                let hasCancelAction = actions[0].style == .cancel || actions[1].style == .cancel
                for (index, button) in buttons.enumerated() {
                    let action = actions[index]
                    button.titleLabel?.font = buttonFont[action.style]
                    if hasCancelAction {
                        if action.style == .cancel && hasCancelAction {
                            button.setBackgroundImage(UIColor.white.toImage(), for: .normal)
                            button.setBackgroundImage(UIColor(red: 255, green: 255, blue: 255, alpha: 0.3).toImage(), for: .highlighted)
                            button.frame = CGRect(x: buttonMargin, y: buttonAreaPositionY, width: buttonWidth, height: buttonHeight)
                            button.setRightSeparator(with: seperatorColor)
                        } else {
                            button.setBackgroundImage(buttonBackgroundColor[action.style]!.toImage(), for: .normal)
                            button.setBackgroundImage(buttonBackgroundColorHighlighted[action.style]!.toImage(), for: .highlighted)
                            button.frame = CGRect(x: buttonMargin + buttonWidth, y: buttonAreaPositionY, width: buttonWidth, height: buttonHeight)
                        }
                    } else {
                        button.setBackgroundImage(buttonBackgroundColor[action.style]!.toImage(), for: .normal)
                        button.setBackgroundImage(buttonBackgroundColorHighlighted[action.style]!.toImage(), for: .highlighted)
                        button.frame = CGRect(x: CGFloat(index) * (buttonMargin + buttonWidth), y: buttonAreaPositionY, width: buttonWidth, height: buttonHeight)
                    }
                    
                    if action.style == .destructive {
                        button.setTitleColor(buttonTextColor[.destructive], for: .normal)
                    } else {
                        button.setTitleColor(buttonSelectedColor, for: .normal)
                    }
                    button.setTitleColor(buttonTextColor[.cancel], for: .disabled)
                    buttonPositionX += buttonMargin + buttonWidth
                }
                buttonAreaPositionY += buttonHeight
            }
            
        } else {
            for (index, button) in buttons.enumerated() {
                let action = actions[button.tag - 1]
                if action.style != AlertAction.Style.cancel {
                    button.titleLabel?.font = buttonFont[action.style]
                    button.setBackgroundImage(buttonBackgroundColor[action.style]!.toImage(), for: .normal)
                    button.setBackgroundImage(buttonBackgroundColorHighlighted[action.style]!.toImage(), for: .highlighted)
                    
                    if index == buttons.count - 1 {
                        if cancelButtonTag == 0 && !Device.isIPhoneXSeries { // no cancel button
                            button.setBottomSeparator(with: seperatorColor)
                        }
                    } else {
                        button.setBottomSeparator(with: seperatorColor)
                    }
                    
                    button.frame = CGRect(x: 0, y: buttonAreaPositionY, width: innerContentWidth, height: buttonHeight)
                    if actions[index].isSelected {
                        button.setTitleColor(buttonSelectedColor, for: .normal)
                    } else {
                        button.setTitleColor(buttonTextColor[action.style], for: .normal)
                    }
                    
                    var buttonLeft: CGFloat = 0
                    if actions[index].contentHorizontalAlignment == .left {
                        button.contentHorizontalAlignment = .left
                        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: alertViewPadding, bottom: 0, right: alertViewPadding)
                        buttonLeft = alertViewPadding
                    }
                    if let image = actions[index].leftImage {
                        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: alertViewPadding * 2, bottom: 0, right: 0)
                        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: alertViewPadding, bottom: 0, right: 0)
                        button.setImage(image, for: .normal)
                        buttonLeft = alertViewPadding * 2
                    }
                    if let rightImage = actions[index].rightImage {
                        let checkmarkImageView =  UIImageView(image: rightImage)
                        checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
                        button.addSubview(checkmarkImageView)
                        button.addConstraint(NSLayoutConstraint(item: checkmarkImageView, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: rightImage.size.height))
                        button.addConstraint(NSLayoutConstraint(item: checkmarkImageView, attribute: .width, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1, constant: rightImage.size.width))
                        button.addConstraint(NSLayoutConstraint(item: checkmarkImageView, attribute: .centerY, relatedBy: .equal, toItem: button, attribute: .centerY, multiplier: 1, constant: 0))
                        button.addConstraint(NSLayoutConstraint(item: checkmarkImageView, attribute: .trailing, relatedBy: .equal, toItem: button, attribute: .trailing, multiplier: 1, constant: -alertViewPadding))
                        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: buttonLeft, bottom: 0, right: alertViewPadding * 2 + rightImage.size.width)
                    }
                    
                    buttonAreaPositionY += buttonHeight + buttonMargin
                } else {
                    cancelButtonTag = button.tag
                }
            }
            
            // Cancel Button
            if cancelButtonTag != 0 {
                if !isAlert && buttons.count > 1 {
                    buttonAreaPositionY += buttonMargin
                }
                let button = buttonAreaScrollView.viewWithTag(cancelButtonTag) as! UIButton
                let action = actions[cancelButtonTag - 1]
                button.titleLabel?.font = buttonFont[action.style]
                button.setTitleColor(buttonTextColor[action.style], for: .normal)
                button.setBackgroundImage(buttonBackgroundColor[action.style]!.toImage(), for: .normal)
                button.setBackgroundImage(buttonBackgroundColorHighlighted[action.style]!.toImage(), for: .highlighted)
        
                button.frame = CGRect(x: 0, y: buttonAreaPositionY, width: innerContentWidth, height: buttonHeight)
                if !isAlert && !Device.isIPhoneXSeries {
                    button.setBottomSeparator(with: seperatorColor)
                }
                buttonAreaPositionY += buttonHeight + buttonMargin
            }
            buttonAreaPositionY -= buttonMargin
        }
        
        if buttons.isEmpty {
            buttonAreaPositionY = 0
        }
        
        // ButtonAreaScrollView Height
        buttonAreaHeight = buttonAreaPositionY
        buttonAreaScrollView.contentSize = CGSize(width: alertViewWidth, height: buttonAreaHeight)
        buttonContainerHeightConstraint?.constant = buttonAreaHeight

        // AlertView Height
        reloadAlertViewHeight()
        alertView.frame.size = CGSize(width: alertViewWidth, height: alertViewHeightConstraint?.constant ?? 150)
        
        if isAlert {
            alertView.layer.masksToBounds = true
            alertView.layer.cornerRadius = 12
        } else {
            let corners: UIRectCorner = [.topLeft,.topRight]
            alertView.corner(byRoundingCorners: corners, radius: 12)
            if cancelButtonTag != 0 {
                alertView.backgroundColor = buttonBackgroundColor[.cancel]
            } else {
                alertView.backgroundColor = .white
            }
        }
    }
    
    // Reload AlertView Height
    func reloadAlertViewHeight() {
        let screenSize = self.presentingViewController != nil ? self.presentingViewController!.view.bounds.size : UIScreen.main.bounds.size
        let maxHeight: CGFloat
        if alertViewMaxHeight != 0 {
            maxHeight = alertViewMaxHeight
        } else {
            maxHeight = screenSize.height * 0.7
        }

        // for avoiding constraint error
        buttonAreaScrollViewHeightConstraint?.constant = 0
        
        // AlertView Height Constraint
        var alertViewHeight = textAreaHeight + buttonAreaHeight
        alertViewHeight = min(alertViewHeight, maxHeight)

        if !isAlert && actionSheetBottomSafeHeight != 0 {
            alertViewHeight += actionSheetBottomSafeHeight
        }
        alertViewHeightConstraint?.constant = alertViewHeight

        // ButtonAreaScrollView Height Constraint
        var buttonAreaScrollViewHeight = buttonAreaHeight
        buttonAreaScrollViewHeight = min(buttonAreaScrollViewHeight, maxHeight)
        buttonAreaScrollViewHeightConstraint?.constant = buttonAreaScrollViewHeight
    }
    
    // Button Tapped Action
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected = true
        let action = actions[sender.tag - 1]
        dismiss(animated: true) {
            self.dimissAction?()
            action.handler?(action)
        }
    }
    
    // Handle DimmingView tap gesture
    @objc func handleBackgroundTapGesture(_ sender: Any) {
        if isEnableTapDimmingViewToDimissed {
            dismiss(animated: true) {
                self.dimissAction?()
            }
        }
    }
    
    // MARK: - Handle NSNotification Method
    @objc func handleAlertActionEnabledDidChangeNotification(_ notification: Notification) {
        for i in 0..<buttons.count {
            buttons[i].isEnabled = actions[i].isEnabled
        }
    }
    
    @objc func handleKeyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: NSValue],
            let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey]?.cgRectValue.size else {
            return
        }
        
        let _keyboardSize = keyboardSize
        keyboardHeight = _keyboardSize.height
        reloadAlertViewHeight()
        containerViewBottomSpaceConstraint?.constant = -keyboardHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func handleKeyboardWillHideNotification(_ notification: Notification) {
        keyboardHeight = 0
        reloadAlertViewHeight()
        containerViewBottomSpaceConstraint?.constant = keyboardHeight
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    // MARK: - Public Methods
    
    // Attaches an action object to the alert or action sheet.
    open func addAction(_ action: AlertAction) {
        // Error
        if action.style == AlertAction.Style.cancel {
            for ac in actions {
                if ac.style == AlertAction.Style.cancel {
                    let error: NSError? = nil
                    NSException.raise(NSExceptionName(rawValue: "NSInternalInconsistencyException"), format:"AlertController can only have one action with a style of AlertActionStyleCancel", arguments:getVaList([error ?? "nil"]))
                    return
                }
            }
        }
        // Add Action
        actions.append(action)
        
        // Add Button
        let button = UIButton()
        button.layer.masksToBounds = true
        button.setTitle(action.title, for: .normal)
        button.isEnabled = action.isEnabled
        button.addTarget(self, action: #selector(AlertController.buttonTapped(_:)), for: .touchUpInside)
        button.tag = buttons.count + 1
        buttons.append(button)
        buttonContainer.addSubview(button)
    }
    
    // Adds a text field to an alert.
    open func addTextField(configurationHandler: ((UITextField) -> Void)?) {
        // You can add a text field only if the preferredStyle property is set to AlertControllerStyle.Alert.
        if !isAlert {
            let error: NSError? = nil
            NSException.raise(NSExceptionName(rawValue: "NSInternalInconsistencyException"), format: "Text fields can only be added to an alert controller of style AlertControllerStyleAlert", arguments: getVaList([error ?? "nil"]))
            return
        }
        
        let textField = UITextField()
        textField.frame.size = CGSize(width: innerContentWidth, height: textFieldHeight)
        textField.borderStyle = .none
        textField.backgroundColor = textFieldBackgroundColor
        textField.delegate = self
        
        configurationHandler?(textField)
        
        if textFields == nil {
            textFields = []
        }
        textFields?.append(textField)
        textFieldContainerView.addSubview(textField)
    }
}

// MARK: - UITextFieldDelegate
extension AlertController: UITextFieldDelegate {
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.canResignFirstResponder {
            textField.resignFirstResponder()
            dismiss(animated: true) {
                self.dimissAction?()
            }
        }
        return true
    }
}
