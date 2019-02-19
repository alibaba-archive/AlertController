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
}
