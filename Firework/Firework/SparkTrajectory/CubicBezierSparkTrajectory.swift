//
//  CubicBezierSparkTrajectory.swift
//  Firework
//
//  Created by 吉乞悠 on 2020/3/8.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

struct CubicBezierTrajectory: Trajectory {

    var points = [CGPoint]()

    init(p1: CGPoint, p2: CGPoint, p3: CGPoint, p4: CGPoint) {
        points.append(p1)
        points.append(p2)
        points.append(p3)
        points.append(p4)
    }

    var path: UIBezierPath {
        assert(points.count == 4, "4 points required")

        let path = UIBezierPath()
        path.move(to: self.points[0])
        path.addCurve(to: self.points[3], controlPoint1: self.points[1], controlPoint2: self.points[2])
        return path
    }
}
