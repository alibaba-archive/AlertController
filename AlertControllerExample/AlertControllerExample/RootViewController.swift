//
//  RootViewController.swift
//  AlertControllerExample
//
//  Created by bruce on 2019/1/31.
//  Copyright © 2019 teambition. All rights reserved.
//

import UIKit
import AlertController

class RootViewController: UIViewController {

    // MARK: - actionsheet
    @IBAction func systemActionSheetButtonPressed(_ sender: Any) {
        let title = "System ActionSheet"
//        let message = "A message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        let otherButtonTitle = "Other Button"
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        // Create the actions.
        let destructiveAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let normalAction = UIAlertAction(title: "Normal Button", style: .default) { action in
            print("normal action")
        }
        
        let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        
        for _ in 0...20 {
            let otherAction = UIAlertAction(title: otherButtonTitle, style: .default) { action in
                print("other action")
            }
            alertController.addAction(otherAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(normalAction)
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func checkmarkButtonPressed(_ sender: Any) {
        let title = "Checkmark ActionSheet"
        let message = "A message should be a short, complete se se seese esesese sese message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        let otherButtonTitle = "Other Button"
        
        let alertController = AlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        destructiveAction.contentHorizontalAlignment = .left
        
        let normalAction = AlertAction(title: "Normal ButtonNormal ButtonNormal ButtonNormal ButtonNormal ButtonNormal ButtonNormal ButtonNormal ButtonNormal ButtonNormal ButtonNormal Button", style: .default) { action in
            print("normal action")
        }
        normalAction.contentHorizontalAlignment = .left
        
        let otherAction = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        otherAction.isSelected = true
        otherAction.rightImage = UIImage(named: "checkmarkIcon")
        otherAction.contentHorizontalAlignment = .left
        otherAction.leftImage = UIImage(named: "checkboxIcon")
        
        for _ in 0...3 {
            let otherAction = AlertAction(title: otherButtonTitle, style: .default) { action in
                print("other action")
            }
            alertController.addAction(otherAction)
        }
        
        let otherAction2 = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action2")
        }
        otherAction2.isSelected = true
        otherAction.rightImage = UIImage(named: "checkmarkIcon")
        otherAction2.contentHorizontalAlignment = .left
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(normalAction)
        alertController.addAction(otherAction)
        alertController.addAction(otherAction2)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func standardButtonPressed(_ sender: Any) {
        let title = "Standard ActionSheet"
        let message = "A message should be a short, complete sentence.A message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        let otherButtonTitle = "Other Button"
        
        let alertController = AlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let otherAction = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        otherAction.shouldShowDot = true
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func noTitleButtonPressed(_ sender: Any) {
        let message = "A message should be a short, complete sentence.A message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        let otherButtonTitle = "Other Button"
        
        let alertController = AlertController(title: nil, message: message, preferredStyle: .actionSheet)
        
        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let otherAction = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func noMessageButtonPressed(_ sender: Any) {
        let destructiveButtonTitle = "Destructive"
        let otherButtonTitle = "Other Button"
        
        let alertController = AlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let otherAction = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(otherAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Alert
    @IBAction func stanardAlertButtonPressed(_ sender: Any) {
        
        let title = "Standard ActionSheet"
        let message = "A message should be a short"
        let destructiveButtonTitle = "Destructive"
        let otherButtonTitle = "Other Button"
        
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        destructiveAction.contentHorizontalAlignment = .left
        
        let normalAction = AlertAction(title: "Normal Button", style: .default) { action in
            print("normal action")
        }
        normalAction.contentHorizontalAlignment = .left
        
        let otherAction = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        otherAction.isSelected = true
        otherAction.rightImage = UIImage(named: "checkmarkIcon")
        otherAction.contentHorizontalAlignment = .left
        otherAction.leftImage = UIImage(named: "checkboxIcon")
        
        let otherAction2 = AlertAction(title: otherButtonTitle, style: .default) { action in
            print("other action")
        }
        otherAction2.isSelected = true
        otherAction.rightImage = UIImage(named: "checkmarkIcon")
        otherAction2.contentHorizontalAlignment = .left
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(normalAction)
        alertController.addAction(otherAction)
        alertController.addAction(otherAction2)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func stanardAlertTwoButtonsPressed(_ sender: Any) {
        let title = "Standard Alert"
        let message = "A message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
        
        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func textFieldAlertButtonPressed(_ sender: Any) {
        let title = "Standard Alert"
        let message = "A message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        
        let alertController = AlertController(title: title, message: message, preferredStyle: .alert)
//        alertController.addTextField(configurationHandler: nil)

        // Create the actions.
        let destructiveAction = AlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let cancelAction = AlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "email"
            textField.keyboardType = .emailAddress
            NotificationCenter.default.addObserver(self, selector: #selector(self.textInputStyleAlertTextDidChange(_:)), name: UITextField.textDidChangeNotification, object: textField)
        }
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    @objc func textInputStyleAlertTextDidChange(_ notification: Notification) {
        if let alert = presentedViewController as? AlertController, let okAction = alert.actions.first, let textField = notification.object as? UITextField {
            okAction.isEnabled = textField.text?.count == 2
        }
    }
    
    @IBAction func systemAlertTwoButtonsPressed(_ sender: Any) {
        let title = "System Alert"
        let message = "A message should be a short, complete sentence."
        let destructiveButtonTitle = "Destructive"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addTextField(configurationHandler: nil)
//        alertController.addTextField(configurationHandler: nil)
        
        // Create the actions.
        let destructiveAction = UIAlertAction(title: destructiveButtonTitle, style: .destructive) { action in
            print("destructive action")
        }
        
        let defaultAction = UIAlertAction(title: destructiveButtonTitle, style: .default) { action in
            print("destructive action")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            print("cancel action")
        }
        defaultAction.isEnabled = false
        
        // Add the actions.
        alertController.addAction(destructiveAction)
        alertController.addAction(defaultAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

