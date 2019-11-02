//
//  ChessView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/17.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit
import SpriteKit

protocol ChessViewDelegate {
    func showResult(bool: Bool)
}

class ChessView: UIView {
    
    let chessRatio: CGFloat = 13.0
    
    var chessInfo: ChessInfo
    
    let scene: SKScene
    let skView: SKView
    
    var singleChessLength: CGFloat = 0
    
    var startPoint: [Int] = [0,0]
    
    var charactor: Charactor
    
    var moveCount = 0
    var filteredCount = 0
    
    var delegate: ChessViewDelegate?
    
    var seq: [(type: ChessRoadType, direction: CharactorDirection)] = []
    
    init(frame: CGRect, chessInfo: ChessInfo) {
        self.chessInfo = chessInfo
        self.scene = SKScene(size: frame.size)
        self.skView = SKView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        self.charactor = Charactor(chapter: chessInfo.chessChapter,size: CGSize(width: singleChessLength, height: singleChessLength))
        
        super.init(frame: frame)
        
        backgroundColor = .clear
        singleChessLength = frame.width / chessRatio
        
        setupChessBoard()
        
        setupCharator()
        
        skView.presentScene(scene)
        
        addSubview(skView)
    }
    
    func setupChessBoard() {
        for i in 0...9 {
            for j in 0...12 {
                if chessInfo.chessBoardInfo[i][j] >= 1 && chessInfo.chessBoardInfo[i][j] <= 6 {
                    let rect = CGRect(x: CGFloat(j) * singleChessLength,
                                      y: CGFloat(i) * singleChessLength,
                                      width: singleChessLength,
                                      height: singleChessLength)
                    let square = ChessRoadView(frame: rect, type: chessInfo.chessBoardInfo[i][j])
                    square.image = UIImage(named: squareKeyWord() + "\(chessInfo.chessBoardInfo[i][j])")
                    addSubview(square)
                } else if chessInfo.chessBoardInfo[i][j] == 9 {
                    let rect = CGRect(x: CGFloat(j) * singleChessLength,
                                      y: CGFloat(i) * singleChessLength,
                                      width: singleChessLength,
                                      height: singleChessLength)
                    let square = UIImageView(frame: rect)
                    square.image = UIImage(named: squareKeyWord() + "\(chessInfo.chessBoardInfo[i][j])")
                    addSubview(square)
                    startPoint[0] = i
                    startPoint[1] = j
                } else if chessInfo.chessBoardInfo[i][j] == 8 {
                    let rect = CGRect(x: CGFloat(j) * singleChessLength,
                                      y: CGFloat(i) * singleChessLength,
                                      width: singleChessLength,
                                      height: singleChessLength)
                    let square = UIImageView(frame: rect)
                    square.image = UIImage(named: squareKeyWord() + "\(chessInfo.chessBoardInfo[i][j])")
                    addSubview(square)
                } else if chessInfo.chessBoardInfo[i][j] == 7 {
                    let rect = CGRect(x: CGFloat(j) * singleChessLength,
                                      y: CGFloat(i) * singleChessLength,
                                      width: singleChessLength,
                                      height: singleChessLength)
                    let square = ChessRoadView(frame: rect, type: 1)
                    square.image = UIImage(named: squareKeyWord() + "1")
                    addSubview(square)
                    let cloud = Charactor(chapter: 33, size: CGSize(width: singleChessLength, height: singleChessLength))
                    cloud.position = CGPoint(x: CGFloat(j) * singleChessLength + singleChessLength / 2,
                                             y: 10.25 * singleChessLength - CGFloat(i) * singleChessLength)
                    scene.addChild(cloud)
                }
            }
        }
    }
    
    func setupCharator() {
        skView.allowsTransparency = true
        scene.backgroundColor = .clear
        
        charactor = Charactor(chapter: chessInfo.chessChapter,size: CGSize(width: singleChessLength, height: singleChessLength))
        charactor.position = CGPoint(x: CGFloat(startPoint[1]) * singleChessLength + singleChessLength / 2,
                                     y: 10.25 * singleChessLength - CGFloat(startPoint[0]) * singleChessLength)
            
        scene.addChild(charactor)
        
        charactor.zRotation = -CGFloat.pi / 2
    }
    
    func startAnimate(seq: [(type: ChessRoadType, direction: CharactorDirection)]) {
        self.seq = seq
        animate()
    }
    
    func animate(){
        if moveCount == chessInfo.chessBoardAnswer.count {
            // 完成了 ***
            showResult(bool: true)
            return
        }
        
        if chessInfo.chessBoardAnswer[moveCount].0 == .horizen || chessInfo.chessBoardAnswer[moveCount].0 == .vertical {
            // 横竖
            charactor.move(moveType: chessInfo.chessBoardAnswer[moveCount].0,
                           moveDirection: chessInfo.chessBoardAnswer[moveCount].1) {
                self.moveCount += 1
                self.animate()
            }
        } else {
            // 转弯
            seq[filteredCount].1 = charactor.direction
            if chessInfo.chessBoardAnswer[moveCount] == seq[filteredCount] {
                // 正确
                charactor.move(moveType: chessInfo.chessBoardAnswer[moveCount].0, moveDirection: chessInfo.chessBoardAnswer[moveCount].1) {
                    self.moveCount += 1
                    self.filteredCount += 1
                    self.animate()
                }
            } else {
                // 错误
                charactor.move(moveType: seq[filteredCount].0, moveDirection: seq[filteredCount].1) {
                    //错误 ***
                    self.showResult(bool: false)
                    return
                }
            }
        }
    }
    
    func showResult(bool: Bool) {
        delegate?.showResult(bool: bool)
    }
    
    func squareKeyWord() -> String {
        var keyWord = ""
        switch chessInfo.chessChapter {
        case 1:
            keyWord = "river_"
        case 2:
            keyWord = "road_"
        case 3:
            keyWord = "air_"
        default:
            keyWord = ""
        }
        return keyWord
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

