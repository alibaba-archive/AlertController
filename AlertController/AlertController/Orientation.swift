//
//  Orientation.swift
//  AlertController
//
//  Created by bruce on 2019/2/22.
//  Copyright © 2019 teambition. All rights reserved.
//

import Foundation

struct Orientation {
    static func orientation() -> UIInterfaceOrientation {
        return UIApplication.shared.statusBarOrientation
    }
    
    static var isLandscape: Bool {
        return orientation().isLandscape
    }
    
    static var isPortrait: Bool {
        return orientation().isPortrait
    }
}
