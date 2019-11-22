<img src="https://dn-st.teambition.net/teambition/images/logo.2328738d.svg" width = "300" height = "200" alt="teambition" align=center />

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/TBMAlertController.svg)](https://img.shields.io/cocoapods/v/TBMAlertController.svg)

## AlertController
 
 Easy and more powerful AlertController in swift, is campatible with UIAlertController API. 
 ![](./AlertController.gif)

### Surpport type
- **alert**
- **actionSheet**

### AlertAction Style
- **default**
- **cancel**
- **destructive**

## Requirements

- iOS 9.0

## Communication

- If you **need help**, please add issues. or send email to <liangming08@gmail.com>

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 9

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate DropdownMenu into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'TBMAlertController'
end
```

Then, run the following command:

```bash
$ pod install
```


### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate DropdownMenu into your Xcode project using Carthage, specify it in your `Cartfile`:

    github "teambition/AlertController"

Run `carthage update` to build the framework 

At last, you need to set up your Xcode project manually to add the AlertController framework.

On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

     /usr/local/bin/carthage copy-frameworks
    
and add the paths to the frameworks you want to use under “Input Files”:

     $(SRCROOT)/Carthage/Build/iOS/AlertController.framework

For more information about how to use Carthage, please see its [project page](https://github.com/Carthage/Carthage)


## Usage

#### Import framework to your class

Cocoapods:

```swift
import TBMAlertController

```

Carthage:

```swift
import AlertController

```

#### Add code for your action

```swift
 @IBAction func systemActionSheetButtonPressed(_ sender: Any) {
        let title = "System ActionSheet"
        // let message = "A message should be a short, complete sentence."
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
```

for detail, Please check the demo

## License

AlertController is released under the MIT license. 

