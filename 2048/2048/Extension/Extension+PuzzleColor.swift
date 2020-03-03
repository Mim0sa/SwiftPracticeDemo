//
//  Extension+PuzzleColor.swift
//  2048
//
//  Created by 吉乞悠 on 2020/3/3.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var pzBackLayerUIColor = UIColor { (trainCollection) -> UIColor in
        if trainCollection.userInterfaceStyle == .dark {
            return UIColor(withHex: 0x7A8B8E)
        } else {
            return UIColor(withHex: 0xFCE2B8)
        }
    }
    
    static var pzBackgroundUIColor = UIColor { (trainCollection) -> UIColor in
        if trainCollection.userInterfaceStyle == .dark {
            return UIColor(withHex: 0x11212D)
        } else {
            return UIColor(withHex: 0xFFDB8D)
        }
    }
    
    static var pzBoardUIColor = UIColor { (trainCollection) -> UIColor in
        if trainCollection.userInterfaceStyle == .dark {
            return UIColor(withHex: 0x2A4C59)
        } else {
            return UIColor(withHex: 0xF8C671)
        }
    }
    
    static func pzCubeUIColor(_ value: PuzzleValue) -> UIColor {
        var hex: UInt?
        switch value {
        case .V_None: hex = 0xffffff
        case .V_2:    hex = 0xFEFA6F
        case .V_4:    hex = 0xCCF757
        case .V_8:    hex = 0xF9B148
        case .V_16:   hex = 0xF4713A
        case .V_32:   hex = 0x5EF9F5
        case .V_64:   hex = 0xFC9DF5
        case .V_128:  hex = 0x60BDFC
        case .V_256:  hex = 0x5594F9
        case .V_512:  hex = 0xB090FC
        case .V_1024: hex = 0xF36FF8
        case .V_2048: hex = 0xF36FF8
        case .V_4096: hex = 0xF36FF8
        case .V_8192: hex = 0xF36FF8
        }
        return UIColor(withHex: hex!)
    }

    static func pzTextUIColor(_ value: PuzzleValue) -> UIColor {
        var hex: UInt?
        switch value {
        case .V_None: hex = 0xffffff
        case .V_2:    hex = 0xF7931E
        case .V_4:    hex = 0xA9CC29
        case .V_8:    hex = 0xEA6A13
        case .V_16:   hex = 0xA31218
        case .V_32:   hex = 0x258C87
        case .V_64:   hex = 0xD82352
        case .V_128:  hex = 0x2283BA
        case .V_256:  hex = 0x1D5FBF
        case .V_512:  hex = 0x6347D6
        case .V_1024: hex = 0x8310BB
        case .V_2048: hex = 0x8310BB
        case .V_4096: hex = 0x8310BB
        case .V_8192: hex = 0x8310BB
        }
        return UIColor(withHex: hex!)
    }
    
}
