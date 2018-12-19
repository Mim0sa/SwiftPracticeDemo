//
//  EatWhatButton.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/12.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class EatWhatButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //setup whatToEatBtn cornerRadius
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        
        //setup whatToEatBtn shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.2
    }
    
}
