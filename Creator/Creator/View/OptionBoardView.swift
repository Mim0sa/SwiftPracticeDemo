//
//  OptionBoardView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/12.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class OptionBoardView: UIView {
    
    let gap: CGFloat = 20
    let cornerRadius: CGFloat = 20
    
    let options: [Int]
    let optionsBtnAry: [UIButton] = []
    
    init(point: CGPoint, height: CGFloat, options: [Int]) {
        // initialize
        self.options = options
        
        // super
        super.init(frame: CGRect(x: point.x, y: point.y, width: CGFloat(options.count) * (height - gap) + gap, height: height))
        
        // preference
        backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        layer.cornerRadius = 20
        
        // setupUI
        setupUI()
    }
    
    func setupUI(){
        for i in 0...options.count - 1 {
            let btn = UIButton(frame: CGRect(x: gap + CGFloat(i) * (frame.height - gap),
                                             y: gap,
                                             width: frame.height - 2 * gap,
                                             height: frame.height - 2 * gap))
            btn.backgroundColor = .randomColor
            btn.layer.cornerRadius = 20
            addSubview(btn)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
