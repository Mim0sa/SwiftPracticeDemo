//
//  PuzzleModel.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation

struct PuzzleModel {
    
    // MARK: - puzzleBoardData
    // |---|---|---|---|
    // |   |   | 2 |   |
    // |---|---|---|---|
    // | 2 |   |   | 4 |
    // |---|---|---|---|
    // |   |   | 2 | 8 |
    // |---|---|---|---|
    // | 2 | 4 | 8 |128|
    // |---|---|---|---|
    var puzzleBoardData: [[PuzzleValue]]
    
    // MARK: - initialize
    init() {
        puzzleBoardData = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
    }
    
    // MARK: - generate new data
    func generateInitialData() -> PuzzleValue {
        return PuzzleValue.V_2
    }
    
    func generateRandomData() -> PuzzleValue {
        return Int.random(in: 1...5) == 1 ? PuzzleValue.V_4 : PuzzleValue.V_2
    }
    
    // MARK: - merge Data
    func mergeData(with direction: PuzzleDirection) {
        
    }
    
}

enum PuzzleValue: Int {
    case V_None = 0
    case V_2    = 2
    case V_4    = 4
    case V_8    = 8
    case V_16   = 16
    case V_32   = 32
    case V_64   = 64
    case V_128  = 128
    case V_256  = 256
    case V_512  = 512
    case V_1024 = 1024
    case V_2048 = 2048
    case V_4096 = 4096
    case V_8192 = 8192
}

enum PuzzleDirection {
    case Left
    case Right
    case Up
    case Down
}
