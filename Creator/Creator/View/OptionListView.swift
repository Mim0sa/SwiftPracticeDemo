//
//  OptionListView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/17.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

protocol OptionListViewDelegate {
    func optionListViewDidDrop(optionViewCenter: CGPoint, optionViewKey: OptionKey) -> Bool
    func startBtnClicked()
    func resetBtnClicked()
}

protocol ViewDidDropedDelegate {
    func viewDidDroped(view: UIView)
}

class OptionListView: UIView {
    
    let gap: CGFloat = 20 * adaptRatio
    let cornerRadius: CGFloat = 20 * adaptRatio
    
    let options: [OptionKey]
    let optionsBtnAry: [UIButton] = []
    
    var panGesture: UIPanGestureRecognizer?
    var currentPanBtnTag: Int?
    let dragView = UIImageView()
    
    var startbtn = UIButton()
    var resetBtn = UIButton()
    
    var delegate: OptionListViewDelegate?
    var viewDidDropedDelegate: ViewDidDropedDelegate?
    
    init(point: CGPoint, width: CGFloat, options: [OptionKey]) {
        // initialize
        self.options = options
        
        // super
        super.init(frame: CGRect(x: point.x, y: point.y, width: width,
                                 height: CGFloat(options.count) * (width - gap) + gap + 2.64 * (width - 2 * gap) + 60))
        
        // preference
        //backgroundColor = .init(r: 0, g: 0, b: 0, a: 0.5)
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        img.image = UIImage(named: "black1")
        addSubview(img)
        
        // setupUI
        setupUI()
        
        //
        startbtn.frame = CGRect(x: gap, y: frame.height - width - gap , width: width - 2 * gap, height: (width - 2 * gap) * 1.32)
        startbtn.setImage(UIImage(named: "start"), for: .normal)
        addSubview(startbtn)
        startbtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        resetBtn.frame = CGRect(x: gap, y: frame.height - 2 * (width + gap), width: width - 2 * gap, height: (width - 2 * gap) * 1.32)
        resetBtn.setImage(UIImage(named: "reset"), for: .normal)
        addSubview(resetBtn)
        resetBtn.addTarget(self, action: #selector(reset), for: .touchUpInside)
    }
    
    @objc func start() {
        delegate?.startBtnClicked()
    }
    
    @objc func reset() {
        delegate?.resetBtnClicked()
    }
    
    func setupUI(){
        // options
        for i in 0...options.count - 1 {
            let btn = UIButton(frame: CGRect(x: gap,
                                             y: gap + CGFloat(i) * (frame.width - gap),
                                             width: frame.width - 2 * gap,
                                             height: frame.width - 2 * gap))
            btn.adjustsImageWhenHighlighted = false
            btn.setImage(UIImage(named: options[i].rawValue), for: .normal)
            btn.tag = 100 + i
            btn.layer.cornerRadius = cornerRadius
            btn.clipsToBounds = true
            addSubview(btn)
            
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
            btn.addGestureRecognizer(panGesture!)
        }
        
        //dragView
        dragView.layer.cornerRadius = cornerRadius
        dragView.clipsToBounds = true
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer){
        //拖动开始
        if recognizer.state == .began {
            viewDidDropedDelegate?.viewDidDroped(view: self)
            
            let btn = recognizer.view as! UIButton
            dragView.frame = btn.frame
            dragView.image = btn.image(for: .normal)
            addSubview(dragView)
            
            currentPanBtnTag = btn.tag - 100
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
        let optionViewConvertFrame = convert(dragView.frame, to: self.superview)
        let optionViewCenter = CGPoint(x: optionViewConvertFrame.midX, y: optionViewConvertFrame.midY)
        // 通过delegate来判断是否接上按钮
        if delegate?.optionListViewDidDrop(optionViewCenter: optionViewCenter,
                                            optionViewKey: options[currentPanBtnTag!]) ?? false {
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
