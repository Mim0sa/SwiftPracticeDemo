//
//  ChapterOneDetailView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/24.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

protocol ChapterDetailViewDidClickedDelegate {
    func chapterDetailViewDidClicked(chessInfo: ChessInfo)
}

class ChapterDetailView: UIView {
    
    var chapter: Int
    var points: [CGPoint]?
    var btns: [UIButton]?
    
    let btnStatus: [Bool] = [true,false,false]
    
    var delegate: ChapterDetailViewDidClickedDelegate?
    
    init(chapter: Int) {
        self.chapter = chapter
        
        super.init(frame: CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT))
        
        self.points = getPoints(with: chapter)
        
        setupUI()
    }
    
    func getPoints(with chapter: Int) -> [CGPoint] {
        switch chapter {
        case 1:
            return [CGPoint(x: 660, y: 160),CGPoint(x: 640, y: 470),CGPoint(x: 230, y: 200),]
        case 2:
            return [CGPoint(x: 220, y: 240),CGPoint(x: 720, y: 460),CGPoint(x: 760, y: 100),]
        case 3:
            return [CGPoint(x: 280, y: 280),CGPoint(x: 720, y: 460),CGPoint(x: 580, y: 100),]
        default:
            return []
        }
    }
    
    func setupUI() {
        for i in 0...points!.count - 1 {
            let btn = UIButton(frame: CGRect(x: points![i].x, y: points![i].y, width: 100, height: 100))
            btn.tag = 100 + i
            btn.setImage(UIImage(named: btnStatus[i] ? "play" : "singleLock"), for: .normal)
            addSubview(btn)
            btns?.append(btn)
            btn.addTarget(self, action: #selector(btnClicked(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func btnClicked(sender: UIButton) {
        var chessInfo = ChessInfoArray[chapter - 1][sender.tag - 100]
        chessInfo.section = sender.tag - 100
        delegate?.chapterDetailViewDidClicked(chessInfo: chessInfo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
