//
//  OptionBoardView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/12.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

protocol OptionBoardViewDelegate {
    func optionBoardViewDidDrop(optionViewCenter: CGPoint) -> Bool
}

class OptionBoardView: UIView {
    
    let gap: CGFloat = 20
    let cornerRadius: CGFloat = 20
    
    let options: [OptionKey]
    let optionsBtnAry: [UIButton] = []
    
    var panGesture: UIPanGestureRecognizer?
    var currentPanBtnTag: Int?
    let dragView = UIView()
    
    var delegate: OptionBoardViewDelegate?
    
    init(point: CGPoint, height: CGFloat, options: [OptionKey]) {
        // initialize
        self.options = options
        
        // super
        super.init(frame: CGRect(x: point.x, y: point.y, width: CGFloat(options.count) * (height - gap) + gap, height: height))
        
        // preference
        backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        layer.cornerRadius = cornerRadius
        
        // setupUI
        setupUI()
    }
    
    func setupUI(){
        // options
        for i in 0...options.count - 1 {
            let btn = UIButton(frame: CGRect(x: gap + CGFloat(i) * (frame.height - gap),
                                             y: gap,
                                             width: frame.height - 2 * gap,
                                             height: frame.height - 2 * gap))
            btn.backgroundColor = .randomColor
            btn.layer.cornerRadius = cornerRadius
            addSubview(btn)
            
            btn.tag = 100 + options[i].rawValue
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
            btn.addGestureRecognizer(panGesture!)
        }
        
        //dragView
        dragView.backgroundColor = .randomColor
        dragView.layer.cornerRadius = cornerRadius
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer){
        //拖动开始
        if recognizer.state == .began {
            dragView.frame = recognizer.view!.frame
            addSubview(dragView)
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
        }
    }
    
    func didDragStop(recognizer: UIPanGestureRecognizer) {
        let optionViewConvertFrame = convert(dragView.frame, to: self.superview)
        let optionViewCenter = CGPoint(x: optionViewConvertFrame.midX, y: optionViewConvertFrame.midY)
        // 通过delegate来判断是否接上按钮
        if delegate?.optionBoardViewDidDrop(optionViewCenter: optionViewCenter) ?? false {
            self.dragView.removeFromSuperview()
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.dragView.frame = recognizer.view!.frame
            }) { (isFinished) in
                self.dragView.removeFromSuperview()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
