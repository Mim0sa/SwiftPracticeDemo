//
//  SparkTrajectory.swift
//  Firework
//
//  Created by 吉乞悠 on 2020/3/10.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

protocol Trajectory {
    var points: [CGPoint] { get set }
    var path: UIBezierPath { get }
}

extension Trajectory {
    /// 缩放轨迹， 在各种形变和 shift: 之前使用
    func scale(by value: CGFloat) -> Trajectory {
        var copy = self
        (0..<self.points.count).forEach { copy.points[$0].multiply(by: value) }
        return copy
    }

    /// 水平翻转轨迹
    func flip() -> Trajectory {
        var copy = self
        (0..<self.points.count).forEach { copy.points[$0].x *= -1 }
        return copy
    }

    /// 偏移轨迹，在各种形变和 `scale(by :)` 之后使用
    func shift(to point: CGPoint) -> Trajectory {
        var copy = self
        let vector = CGVector(dx: point.x, dy: point.y)
        (0..<self.points.count).forEach { copy.points[$0].add(vector: vector) }
        return copy
    }
}
