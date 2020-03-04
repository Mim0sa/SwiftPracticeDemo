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
    var cubeViews: [[PuzzleCubeView?]]
    var boardData: [[PuzzleValue]]
    
    // MARK: - Animator
    let puzzleAnimator = PuzzleAnimator()
    
    // MARK: - Initialize
    init(with boardView: PuzzleBoardView) {
        self.boardView = boardView
        self.cubeEdge = boardView.cubeEdge
        locationPionts = boardView.locationPionts
        boardData = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
        cubeViews = [[PuzzleCubeView?]](repeating: [PuzzleCubeView?](repeating: nil, count: 4), count: 4)
        
    }
    
    // MARK: - Control Flows
    func cleanTheBoard(completion: @escaping () -> Void) {
        boardData = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
        
        puzzleAnimator.vanishAllCubeViews(cubeViews) {
            self.cubeViews = [[PuzzleCubeView?]](repeating: [PuzzleCubeView?](repeating: nil, count: 4), count: 4)
            completion()
        }
    }
    
    func showTwoInitialCube(_ value: (v1: PuzzleValue, v2: PuzzleValue), completion: @escaping ([[PuzzleValue]]) -> Void) {
        let chainIndex = getInitialPositionIndex()
        
        // generate two initial cubeViews
        let cubeView1 = PuzzleCubeView(position: locationPionts[chainIndex.p1],
                                      cubeEdge: cubeEdge,
                                      cubeStatus: .Shrinked,
                                      puzzleValue: value.v1)
        let cubeView2 = PuzzleCubeView(position: locationPionts[chainIndex.p2],
                                       cubeEdge: cubeEdge,
                                       cubeStatus: .Shrinked,
                                       puzzleValue: value.v2)
        
        // update board data
        let coordinate1 = convertChainToCoordinate(chainIndex.p1)
        let coordinate2 = convertChainToCoordinate(chainIndex.p2)
        boardData[coordinate1.row][coordinate1.col] = value.v1
        boardData[coordinate2.row][coordinate2.col] = value.v2
        
        // update cubeViews
        cubeViews[coordinate1.row][coordinate1.col] = cubeView1
        cubeViews[coordinate2.row][coordinate2.col] = cubeView2
        
        boardView.addSubview(cubeView1)
        boardView.addSubview(cubeView2)
        puzzleAnimator.expandCubeViews([cubeView1, cubeView2]) {
            completion(self.boardData)
        }
    }
    
    func showANewCube(_ value: PuzzleValue, completion: @escaping ([[PuzzleValue]]) -> Void) {
        let position = getRandomEmptyPosition()
        // generate cubeView
        let cubeView = PuzzleCubeView(position: locationPionts[convertCoordinateToChain(position)],
                                      cubeEdge: cubeEdge,
                                      cubeStatus: .Shrinked,
                                      puzzleValue: value)
        // update board data
        boardData[position.row][position.col] = value
        // update cubeViews
        cubeViews[position.row][position.col] = cubeView
        
        boardView.addSubview(cubeView)
        puzzleAnimator.expandCubeViews([cubeView]) {
            completion(self.boardData)
        }
    }
    
    // MARK: - Tricky Methods
    func getRandomEmptyPosition() -> (row: Int, col: Int) {
        var coordinate = convertChainToCoordinate(Int.random(in: 0...15))
        if boardData[coordinate.row][coordinate.col] == .V_None {
            coordinate = getRandomEmptyPosition()
        }
        return coordinate
    }
    
    func getInitialPositionIndex() -> (p1: Int, p2: Int) {
        var initialPositionIndex = (Int.random(in: 0...15), Int.random(in: 0...15))
        if initialPositionIndex.0 == initialPositionIndex.1 {
            initialPositionIndex = getInitialPositionIndex()
        }
        return initialPositionIndex
    }
    
    func convertChainToCoordinate(_ chainValue: Int) -> (row: Int, col: Int) {
        assert(chainValue < 15 || chainValue > 0, "chainValue should in 0...15")
        let row = chainValue / 4
        let col = (chainValue + 4) % 4
        return (row, col)
    }
    
    func convertCoordinateToChain(_ coordinate: (row: Int, col: Int)) -> Int {
        return coordinate.row * 4 + coordinate.col
    }
    
    // MARK: For Test
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

