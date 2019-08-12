//
//  EatWhatButton.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/12.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class EatWhatButton: UIButton {
    
    enum eatWhatBtnStatus {
        case normal
        case selected
    }
    
    var status: eatWhatBtnStatus {
        didSet {
            switch status {
            case .normal:
                setTitle("长按开始", for: .normal)
                backgroundColor = UIColor.darkGray
                break
            case .selected:
                setTitle("松手停止", for: .normal)
                backgroundColor = UIColor.lightGray
                break
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        //setup allproperty
        status = .normal
        
        //super.init
        super.init(coder: aDecoder)
        
        //setup whatToEatBtn cornerRadius
        layer.cornerRadius = self.frame.height / 2
        layer.masksToBounds = false
        
        //setup whatToEatBtn shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.2
    }
    
}
