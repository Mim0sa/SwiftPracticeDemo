//
//  ClassicSparkTrajectoryFactory.swift
//  Firework
//
//  Created by 吉乞悠 on 2020/3/9.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation

protocol SparkTrajectoryFactory {}

protocol ClassicSparkTrajectoryFactoryProtocol: SparkTrajectoryFactory {

    func randomTopRight() -> SparkTrajectory
    func randomBottomRight() -> SparkTrajectory
}
