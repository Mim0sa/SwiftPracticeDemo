//
//  ChessInfo.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/18.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import Foundation

struct ChessInfo {
    
    let chessChapter: Int
    var section: Int?
    let chessBoardInfo: [[Int]]
    let chessBoardAnswer: [(type: ChessRoadType, direction: CharactorDirection)]
    let options: [OptionKey]
    let programBlockNum: Int
    
    let filteredAnswer: [(type: ChessRoadType, direction: CharactorDirection)]
    
    init(chessChapter: Int, chessBoardInfo: [[Int]], chessBoardAnswer: [(type: ChessRoadType, direction: CharactorDirection)],
         options: [OptionKey], programBlockNum: Int) {
        self.chessChapter = chessChapter
        self.chessBoardInfo = chessBoardInfo
        self.chessBoardAnswer = chessBoardAnswer
        self.options = options
        self.programBlockNum = programBlockNum
        
        var answers: [(type: ChessRoadType, direction: CharactorDirection)] = []
        for tupe in chessBoardAnswer {
            if tupe.0 != .horizen && tupe.0 != .vertical {
                answers.append(tupe)
            }
        }
        self.filteredAnswer = answers
    }
    
}

enum ChessRoadType : Int {
    case horizen = 1
    case vertical = 2
    case turnRight = 3
    case turnDown = 4
    case turnLeft = 5
    case turnUp = 6
    case cloud = 7
}






















//let chessInfoDic: [Int:String] = [0:"",
//                                  1:"road_1",
//                                  2:"road_2",
//                                  3:"road_3",
//                                  4:"road_4",
//                                  5:"road_5",
//                                  6:"road_6",
//                                  7:"",
//                                  8:"",
//                                  9:"",
//                                  10:"",
//                                  11:"river_1",
//                                  12:"river_2",
//                                  13:"river_3",
//                                  14:"river_4",
//                                  15:"river_5",
//                                  16:"river_6",
//                                  17:"",
//                                  18:"",
//                                  19:"",
//                                  20:"",
//                                  21:"road_1",
//                                  22:"road_2",
//                                  23:"road_3",
//                                  24:"road_4",
//                                  25:"road_5",
//                                  26:"road_6",
//                                  27:"",
//                                  28:"",
//                                  29:""]

