//
//  PPToastNavigationBar.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/16.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPToastNavigationBar: UIView {
    
    var title: String? {
        willSet {
            barTitle.text = newValue
        }
    }
    
    private let barTitle = UILabel()

    init() {
        super.init(frame: CGRect())
        
        backgroundColor = .navigatorBlack
        
        barTitle.text = ""
        barTitle.textColor = .titleWhite
        barTitle.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        addSubview(barTitle)
        barTitle.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.bottom.equalTo(-12)
            make.height.equalTo(44)
            make.left.equalTo(28)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
