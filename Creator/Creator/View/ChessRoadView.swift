//
//  ChessRoadView.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/10/21.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit
import SpriteKit

class ChessRoadView: UIImageView {

    let type: ChessRoadType
    
    init(frame: CGRect, type: Int) {
        self.type = ChessRoadType(rawValue: type)!
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
