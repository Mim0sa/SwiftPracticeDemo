//
//  PuzzleBoardCoordinator.swift
//  2048
//
//  Created by 吉乞悠 on 2020/3/1.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

class PuzzleBoardCoordinator {
    
    // MARK: - Outlets
    let boardView: PuzzleBoardView
    
    // MARK: - Varibles
    var locationPionts: [CGPoint]
    var cubeViews: [Int:PuzzleCubeView] = [:]
    
    // MARK: - Initialize
    init(with boardView: PuzzleBoardView) {
        self.boardView = boardView
        locationPionts = boardView.locationPionts
    }
    
}

