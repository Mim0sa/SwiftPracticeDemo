//
//  Extension+Random.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/14.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

func getRandomInt(from: Int, to: Int) -> Int {
    return Int(arc4random_uniform(UInt32(to - from + 1))) + from
}

func getRandomCGFloat(from: Int, to: Int) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(to - from + 1))) + CGFloat(from)
}
