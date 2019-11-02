//
//  ProgramListView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/17.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class ProgramListView: UIView {
    
    let gap: CGFloat = 20 * adaptRatio
    let cornerRadius: CGFloat = 20 * adaptRatio
    
    let blockNum: Int
    
    var viewDidDropedDelegate: ViewDidDropedDelegate?
    
    var programBtnAry: [UIButton] = []
    var programListData: [OptionKey] = [] {
        didSet {
            for i in 0...programBtnAry.count - 1 {
                programBtnAry[i].setImage(UIImage(named: programListData[i].rawValue), for: .normal)
                if programListData[i] == .Null {
                    programBtnAry[i].isUserInteractionEnabled = false
                } else {
                    programBtnAry[i].isUserInteractionEnabled = true
                }
            }
        }
    }
    
    var frameOfProgramList: [CGRect] {
        get {
            var rectOfProgramList: [CGRect] = []
            for btn in programBtnAry {
                let rect = convert(btn.frame, to: self.superview)
                rectOfProgramList.append(rect)
            }
            return rectOfProgramList
        }
    }
    
    var panGesture: UIPanGestureRecognizer?
    var currentPanBtnTag: Int?
    let dragView = UIImageView()
    
    var delegate: OptionListViewDelegate?

    init(point: CGPoint, width: CGFloat, blockNum: Int) {
        // initialize
        self.blockNum = blockNum
        
        // super
        super.init(frame: CGRect(x: point.x, y: point.y, width: width, height: SCREENHEIGHT))
        
        // preference
        backgroundColor = .init(r: 0, g: 0, b: 0, a: 0.5)
        
        // setupUI
        setupUI()
    }
    
    func setupUI(){
        //programList
        var listData:[OptionKey] = []
        for i in 0...blockNum - 1 {
            let btn = UIButton(frame: CGRect(x: gap,
                                             y: gap + CGFloat(i) * (frame.width - gap),
                                             width: frame.width - 2 * gap,
                                             height: frame.width - 2 * gap))
            btn.adjustsImageWhenHighlighted = false
            btn.tag = 100 + i
            btn.layer.cornerRadius = cornerRadius
            btn.clipsToBounds = true
            addSubview(btn)
            programBtnAry.append(btn)
            listData.append(.Null)
            
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
            btn.addGestureRecognizer(panGesture!)
        }
        programListData = listData
        
        //dragView
        dragView.layer.cornerRadius = cornerRadius
        dragView.clipsToBounds = true
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer){
        //拖动开始
        if recognizer.state == .began {
            viewDidDropedDelegate?.viewDidDroped(view: self)
            
            let btn = recognizer.view as! UIButton
            currentPanBtnTag = btn.tag - 100
            
            dragView.frame = btn.frame
            dragView.image = btn.image(for: .normal)
            addSubview(dragView)
            btn.setImage(UIImage(named: OptionKey.Null.rawValue), for: .normal)
            
        }
        //拖动过程
        else if recognizer.state == .changed {
            let translation = recognizer.translation(in: self.superview)
            dragView.frame = CGRect(x: recognizer.view!.frame.minX + translation.x,
                                    y: recognizer.view!.frame.minY + translation.y,
                                    width: recognizer.view!.frame.width,
                                    height: recognizer.view!.frame.height)
        }
        //拖动结束
        else if recognizer.state == .ended {
            didDragStop(recognizer: recognizer)
            
            currentPanBtnTag = nil
        }
    }
    
    func didDragStop(recognizer: UIPanGestureRecognizer) {
        if recognizer.view!.frame.contains(dragView.center) {
            UIView.animate(withDuration: 0.4, animations: {
                self.dragView.frame = recognizer.view!.frame
            }) { (isFinished) in
                let ary = self.programListData
                self.programListData = ary
                self.dragView.removeFromSuperview()
            }
        } else {
            programListData[currentPanBtnTag!] = .Null
            self.dragView.removeFromSuperview()
        }
    }
    
    // MARK: - drop判定
    func isDropContains(optionViewCenter: CGPoint, optionViewKey: OptionKey) -> Bool {
        for i in 0...frameOfProgramList.count - 1 {
            if frameOfProgramList[i].contains(optionViewCenter) {
                programListData[i] = optionViewKey
                return true
            }
        }
        return false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
