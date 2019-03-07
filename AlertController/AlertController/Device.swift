//
//  Device.swift
//  AlertController
//
//  Created by bruce on 2019/2/22.
//  Copyright © 2019 teambition. All rights reserved.
//

import Foundation

struct Device {
    static let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    static let isPad = UIDevice.current.userInterfaceIdiom == .pad
    
    static let isIPhoneX = Screen.size == DeviceSize.Portrait.iPhoneX || Screen.size == DeviceSize.Landscape.iPhoneX
    static let isIPhoneXSMax = Screen.size == DeviceSize.Portrait.iPhoneXSMax || Screen.size == DeviceSize.Landscape.iPhoneXSMax
    static let isIPhoneXR = Screen.size == DeviceSize.Portrait.iPhoneXR || Screen.size == DeviceSize.Landscape.iPhoneXR
    /// 是否为具有刘海全面屏的 iPhone X 系列机型
    static let isIPhoneXSeries = isIPhoneX || isIPhoneXSMax || isIPhoneXR
}

struct Screen {
    static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    static var width: CGFloat {
        return size.width
    }
    
    static var height: CGFloat {
        return size.height
    }
}

struct DeviceSize {
    struct Landscape {
        static let iPhoneX = CGSize(width: 812, height: 375)
        static let iPhoneXSMax = CGSize(width: 896, height: 414)
        static let iPhoneXR = CGSize(width: 896, height: 414)
    }
    
    struct Portrait {
        static let iPhoneX = CGSize(width: 375, height: 812)
        static let iPhoneXSMax = CGSize(width: 414, height: 896)
        static let iPhoneXR = CGSize(width: 414, height: 896)
    }
}
