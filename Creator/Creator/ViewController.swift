//
//  ViewController.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/12.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var chessInfo: ChessInfo
    
    init(chessInfo: ChessInfo) {
        self.chessInfo = chessInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    lazy var p = ProgramListView(point: CGPoint(), width: 150 * adaptRatio, blockNum: chessInfo.programBlockNum)
    lazy var o = OptionListView(point: CGPoint(), width: 150 * adaptRatio, options: chessInfo.options)
    lazy var c = ChessView(frame: CGRect(x: 50 * adaptRatio, y: 150 * adaptRatio,
                                         width: SCREENWIDTH - 400 * adaptRatio,
                                         height: SCREENHEIGHT - 225 * adaptRatio),
                           chessInfo: chessInfo)
    
    var v: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bgImageView = UIImageView(frame: view.frame)
        bgImageView.image = UIImage(named: "Chapter" + "\(chessInfo.chessChapter)" + "_Background")
        view.addSubview(bgImageView)
        
        c.delegate = self
        view.addSubview(c)
        
//        if chessInfo.chessChapter == 2 {
//            let shav = UIView(frame: view.frame)
//            shav.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.9)
//            view.addSubview(shav)
//
//            let maskView = UIView()
//            maskView.frame = c.frame
//            maskView.center = c.center
//            maskView.layer.cornerRadius = 50
//            shav.mask = maskView
//        }
        
        o.delegate = self
        o.viewDidDropedDelegate = self
        o.frame = CGRect(x: SCREENWIDTH - 300 * adaptRatio,
                         y: 0,
                         width: o.frame.width,
                         height: o.frame.height)
        view.addSubview(o)
        
        p.viewDidDropedDelegate = self
        p.frame = CGRect(x: SCREENWIDTH - 150 * adaptRatio,
                         y: 0,
                         width: p.frame.width,
                         height: p.frame.height)
        view.addSubview(p)
        
        let backBtn = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        backBtn.setImage(UIImage(named: "back"), for: .normal)
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
    }
    
    @objc func back(sender: UIButton) {
        self.present(HomeViewContoller(), animated: true) {
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ViewController: OptionListViewDelegate, ViewDidDropedDelegate {
    func startBtnClicked() {
        var seq: [(type: ChessRoadType, direction: CharactorDirection)] = []
        for i in 0...p.programListData.count - 1 {
            seq.append((type: getType(key: p.programListData[i]), direction: .Right))
        }
        c.startAnimate(seq: seq)
    }
    
    func getType(key: OptionKey) -> ChessRoadType {
        switch key {
        case .Null:
            return .turnRight
        case .Left:
            return .turnLeft
        case .Right:
            return .turnRight
        case .Up:
            return .turnUp
        case .Down:
            return .turnDown
        case .Cloud:
            return .cloud
        }
    }
    
    func resetBtnClicked() {
        //
        c.removeFromSuperview()
        c = ChessView(frame: CGRect(x: 50 * adaptRatio, y: 150 * adaptRatio,
                                    width: SCREENWIDTH - 400 * adaptRatio,
                                    height: SCREENHEIGHT - 225 * adaptRatio),
                      chessInfo: ChessInfoArray[chessInfo.chessChapter - 1][chessInfo.section!])
        view.addSubview(c)
    }
    
    func optionListViewDidDrop(optionViewCenter: CGPoint, optionViewKey: OptionKey) -> Bool {
        return p.isDropContains(optionViewCenter: optionViewCenter, optionViewKey: optionViewKey)
    }
    
    func viewDidDroped(view: UIView) {
        self.view.bringSubviewToFront(view)
    }
}

extension ViewController: ChessViewDelegate {
    func showResult(bool: Bool) {
        showResultViews(bool: bool)
    }
    
    func showResultViews(bool: Bool) {
        v = UIView(frame: view.frame)
        v!.alpha = 1
        v!.backgroundColor = UIColor(r: 0, g: 0, b: 0, a: 0.3)
        view.addSubview(v!)
        
        let img = UIButton(frame: CGRect(x: SCREENWIDTH / 2 - 50, y: SCREENHEIGHT / 2 - 50, width: 100, height: 100))
        img.setImage(UIImage(named: bool ? "yes" : "no"), for: .normal)
        v!.addSubview(img)
        
        UIView.animate(withDuration: 1, delay: 2, options: [], animations: {
            self.v!.alpha = 0
        }) { (_) in
            self.v!.removeFromSuperview()
            self.v = nil
            if self.chessInfo.section != 2 {
                let chessInfo2 = ChessInfoArray[self.chessInfo.chessChapter - 1][self.chessInfo.section! + 1]
                if bool {
                    let vc = ViewController(chessInfo: chessInfo2)
                    self.present(vc, animated: true) {
                        vc.chessInfo.section = self.chessInfo.section! + 1
                    }
                }
            }
        }
    }
    
}
