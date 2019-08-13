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
    static var randomColor: UIColor {
        get {
            return UIColor(red: getRandomCGFloat(from: 0, to: 255) / 255,
                           green: getRandomCGFloat(from: 0, to: 255) / 255,
                           blue: getRandomCGFloat(from: 0, to: 255) / 255,
                           alpha: 1)
        }
    }
    
}
