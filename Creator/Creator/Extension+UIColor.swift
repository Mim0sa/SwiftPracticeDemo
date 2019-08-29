//
//  Extension+UIColor.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/13.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // MARK: - 随机色
    static var randomColor: UIColor {
        get {
            return UIColor(red: getRandomCGFloat(from: 0, to: 255) / 255,
                           green: getRandomCGFloat(from: 0, to: 255) / 255,
                           blue: getRandomCGFloat(from: 0, to: 255) / 255,
                           alpha: 1)
        }
    }
    // MARK: - RGB
    convenience init(r: Int, g: Int, b: Int) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    // MARK: - Hex
    convenience init(hex: Int) {
        self.init(r:(hex >> 16) & 0xff, g:(hex >> 8) & 0xff, b:hex & 0xff)
    }
    
}
