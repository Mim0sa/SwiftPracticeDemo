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
    var cubeEdge: CGFloat
    var locationPionts: [CGPoint]
    var cubeViews: [[PuzzleCubeView?]] = []
    var boardData: [[PuzzleValue]] = []
    
    // MARK: - Animator
    let puzzleAnimator = PuzzleAnimator()
    
    // MARK: - Initialize
    init(with boardView: PuzzleBoardView) {
        self.boardView = boardView
        self.cubeEdge = boardView.cubeEdge
        locationPionts = boardView.locationPionts
    }
    
    // MARK: - Control Flows
    func cleanTheBoard(completion: @escaping () -> Void) {
        boardData = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
        
        puzzleAnimator.vanishAllCubeViews(cubeViews) {
            completion()
        }
    }
    
    func showTwoInitialCube(_ value: (v1: PuzzleValue, v2: PuzzleValue), completion: @escaping () -> Void) {
        let positionIndex = getInitialPositionIndex()
        // generate two initial cubeViews
        let cubeView1 = PuzzleCubeView(position: locationPionts[positionIndex.p1],
                                      cubeEdge: cubeEdge,
                                      cubeStatus: .Shrinked,
                                      puzzleValue: value.v1)
        let cubeView2 = PuzzleCubeView(position: locationPionts[positionIndex.p2],
                                       cubeEdge: cubeEdge,
                                       cubeStatus: .Shrinked,
                                       puzzleValue: value.v2)
        // 
        boardView.addSubview(cubeView1)
        puzzleAnimator.expandCubeView(cubeView1) {
            self.boardView.addSubview(cubeView2)
            self.puzzleAnimator.expandCubeView(cubeView2) {
                completion()
            }
        }
    }
    
    // MARK: - tricky methods
    func getInitialPositionIndex() -> (p1: Int, p2: Int) {
        var initialPositionIndex = (Int.random(in: 0...15), Int.random(in: 0...15))
        if initialPositionIndex.0 == initialPositionIndex.1 {
            initialPositionIndex = getInitialPositionIndex()
        }
        return initialPositionIndex
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

