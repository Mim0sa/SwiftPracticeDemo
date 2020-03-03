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
    var cubeViews: [[PuzzleCubeView?]] = []
    var boardData: [[PuzzleValue]] = []
    
    // MARK: - Animator
    let puzzleAnimator = PuzzleAnimator()
    
    // MARK: - Initialize
    init(with boardView: PuzzleBoardView) {
        self.boardView = boardView
        locationPionts = boardView.locationPionts
    }
    
    // MARK: - Control Flows
    func cleanTheBoard(completion: @escaping () -> Void) {
        boardData = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
        
        puzzleAnimator.vanishAllCubeViews(cubeViews) {
            completion()
        }
    }
    
    // MARK: for test
    func generateAllCubes() {
        let line = boardView.generateAllCubes()
        boardData = [[.V_2, .V_4, .V_8, .V_16],
                     [.V_32, .V_64, .V_128, .V_256],
                     [.V_512, .V_1024, .V_2048, .V_4096],
                     [.V_8192, .V_None, .V_None, .V_None]]
        cubeViews = [[line[0], line[1], line[2], line[3]],
                     [line[4], line[5], line[6], line[7]],
                     [line[8], line[9], line[10], line[11]],
                     [line[12], nil   , nil    , nil]]
        
    }
    
}

