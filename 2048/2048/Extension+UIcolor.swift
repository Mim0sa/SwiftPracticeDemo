//
//  Extension+UIcolor.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: initialize with RGBA
    convenience init(withRGBA value: (CGFloat, CGFloat, CGFloat, CGFloat)) {
        self.init(red:   value.0 / 255,
                  green: value.1 / 255,
                  blue:  value.2 / 255,
                  alpha: value.3)
    }
    
    // MARK: initialize with RGB
    convenience init(withRGB value: (CGFloat, CGFloat, CGFloat)) {
        self.init(red:   value.0 / 255,
                  green: value.1 / 255,
                  blue:  value.2 / 255,
                  alpha: 1)
    }
    
    // MARK: initialize with hex & alpha
    convenience init(withHex value: (hex: UInt, alpha: CGFloat)) {
        self.init(red:   CGFloat((value.hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((value.hex & 0xFF0000) >> 16) / 255.0,
                  blue:  CGFloat((value.hex & 0xFF0000) >> 16) / 255.0,
                  alpha: value.alpha)
    }
    
    // MARK: initialize with hex
    convenience init(withHex hex: UInt) {
        self.init(red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((hex & 0xFF00) >> 8)    / 255.0,
                  blue:  CGFloat(hex & 0xFF)             / 255.0,
                  alpha: 1)
    }
    
    // MARK: initialize with name
    convenience init?(_ name: String) {
        self.init(named: name)
    }
    
    // MARK: random UIColor
    static var randomColor: UIColor {
        let randomColor = UIColor(red:   CGFloat.random(in: 0...255) / 255,
                                  green: CGFloat.random(in: 0...255) / 255,
                                  blue:  CGFloat.random(in: 0...255) / 255,
                                  alpha: 1)
        return randomColor
    }
    
    // MARK: resolved CGColor
    func cgColor(with traitCollection: UITraitCollection) -> CGColor {
        return resolvedColor(with: traitCollection).cgColor
    }
}
