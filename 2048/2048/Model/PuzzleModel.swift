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
    var testBoardData: [[PuzzleValue]] = [[PuzzleValue.V_4, PuzzleValue.V_2, PuzzleValue.V_4, PuzzleValue.V_2],
                                          [PuzzleValue.V_2, PuzzleValue.V_4, PuzzleValue.V_2, PuzzleValue.V_4],
                                          [PuzzleValue.V_4, PuzzleValue.V_2, PuzzleValue.V_4, PuzzleValue.V_2],
                                          [PuzzleValue.V_2, PuzzleValue.V_8, PuzzleValue.V_2, PuzzleValue.V_4]]
    
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
    mutating func mergeData(with direction: PuzzleDirection) -> [[PuzzleValue]] {
        var boardData = self.testBoardData
        switch direction {
        case .Left, .Right:
            for i in 0...boardData.count - 1 { boardData[i] = mergeOneLine(line: boardData[i], direction: direction) }
        case .Up, .Down:
            var transposedData = transpose(boardData)
            for i in 0...boardData.count - 1 { transposedData[i] = mergeOneLine(line: transposedData[i], direction: direction) }
            boardData = transpose(transposedData)
        }
        return boardData
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
    
    // MARK: - checkIfGameOver
    mutating func checkIfIsFinished() -> Bool {
        //
        boardData = testBoardData
        
        func checkHorizontally(_ boardData: [[PuzzleValue]]) -> Bool {
            for i in 0...boardData.count - 1 {
                for j in 0...boardData[i].count - 2 {
                    if boardData[i][j] == boardData[i][j + 1] {
                        return false
                    }
                }
            }
            return true
        }
         
        if checkHorizontally(boardData) && checkHorizontally(transpose(boardData)) { return true }
        return false
    }
    
    // MARK: - transpose the matrix
    func transpose(_ data: [[PuzzleValue]]) -> [[PuzzleValue]] {
        var tmp = [[PuzzleValue]](repeating: [PuzzleValue](repeating: .V_None, count: 4), count: 4)
        for i in 0...data[0].count - 1 {
            for j in 0...data.count - 1 {
                tmp[i][j] = data[j][i]
            }
        }
        return tmp
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
