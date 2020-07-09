//
//  PPBarItemButton.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/7/9.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPBarItemButton: UIButton {
    
    override var isHighlighted: Bool {
        didSet { backgroundColor = isHighlighted ? .contentGray : .textFieldGray }
    }

    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        backgroundColor = .textFieldGray 
        
        layer.cornerRadius = 6
        
        snp.makeConstraints { (make) in make.size.equalTo(CGSize(width: 58, height: 30)) }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
