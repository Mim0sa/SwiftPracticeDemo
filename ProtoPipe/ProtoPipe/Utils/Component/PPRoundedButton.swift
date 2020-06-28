//
//  PPRoundedButton.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/6/27.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPRoundedButton: UIButton {

    init(type: PPRoundedButtonType) {
        super.init(frame: CGRect())
        
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        switch type {
        case .Cancel:
            setTitleColor(.subtitleGray, for: .normal)
            setTitleColor(.gray, for: .highlighted)
            backgroundColor = .contentGray
            setTitle("Cancel", for: .normal)
        case .Confirm:
            setTitleColor(.navigatorBlack, for: .normal)
            setTitleColor(.darkGray, for: .highlighted)
            backgroundColor = .activeGreen
            setTitle("Confirm", for: .normal)
        }

    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

enum PPRoundedButtonType {
    case Cancel
    case Confirm
}
