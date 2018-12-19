//
//  CustomizeButton.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/18.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class CustomizeButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //setup whatToEatBtn cornerRadius
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = false
        
    }

}
