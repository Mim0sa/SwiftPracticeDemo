//
//  PuzzleModel.swift
//  2048
//
//  Created by 吉乞悠 on 2020/2/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import Foundation

struct PuzzleModel {
    
    // MARK: - boardData
    // |---|---|---|---|
    // |   |   | 2 |   |
    // |---|---|---|---|
    // | 2 |   |   | 4 |
    // |---|---|---|---|
    // |   |   | 2 | 8 |
    // |---|---|---|---|
    // | 2 | 4 | 8 |128|
    // |---|---|---|---|
    var boardData: [[PuzzleValue]]
    var testBoardDataLine: [PuzzleValue] = [.V_2, .V_4, .V_4, .V_4]
    
    // MARK: - initialize
    init() {
        boardData = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
    }
    
    // MARK: - generate new data
    func generateInitialData() -> PuzzleValue {
        return PuzzleValue.V_2
    }
    
    func generateRandomData() -> PuzzleValue {
        return Int.random(in: 1...5) == 1 ? PuzzleValue.V_4 : PuzzleValue.V_2
    }
    
    // MARK: - merge Data
    func mergeData(with direction: PuzzleDirection) -> [[PuzzleDirection]] {
        switch direction {
        case .Left:
            break
        case .Right:
            break
        case .Up:
            break
        case .Down:
            break
        }
        return []
    }
    
    func mergeOneLine(line: [PuzzleValue], direction: PuzzleDirection) -> [PuzzleValue] {
        
        var needToReverse: Bool = {
            switch direction {
            case .Left, .Up:
                return false
            case .Right, .Down:
                return true
            }
        }()
        
        func makeIndentation(_ line: [PuzzleValue]) -> [PuzzleValue] {
            var indentLine: [PuzzleValue] = []
            var indentationCount = 0
            line.forEach { (value) in
                if value != .V_None { indentLine.append(value) } else { indentationCount += 1 }
            }
            while indentationCount > 0 {
                if needToReverse { indentLine.insert(.V_None, at: 0) } else { indentLine.append(.V_None) }
                indentationCount -= 1
            }
            return indentLine
        }
        
        func mergeSameValue(_ line: [PuzzleValue]) -> [PuzzleValue] {
            var mergedLine: [PuzzleValue] = line
            for i in 0...mergedLine.count - 2 {
                let pioneer = needToReverse ? mergedLine.count - i - 1 : i
                let nexter  = needToReverse ? mergedLine.count - i - 2 : i + 1
                if mergedLine[pioneer] == mergedLine[nexter] {
                    assert(PuzzleValue(rawValue: mergedLine[pioneer].rawValue * 2) != nil, "puzzleValue should not be nil")
                    mergedLine[pioneer] = PuzzleValue(rawValue: mergedLine[pioneer].rawValue * 2) ?? PuzzleValue.V_None
                    mergedLine[nexter] = .V_None
                }
            }
            return mergedLine
        }
        
        return makeIndentation(mergeSameValue(makeIndentation(line)))
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
