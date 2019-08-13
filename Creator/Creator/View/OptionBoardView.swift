//
//  OptionBoardView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/12.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class OptionBoardView: UIView {
    
    init(point: CGPoint, height: CGFloat, numberOfOptions: Int) {
        super.init(frame: CGRect(x: point.x, y: point.y, width: CGFloat(numberOfOptions) * height, height: height))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
