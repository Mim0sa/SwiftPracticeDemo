//
//  PPToastNavigationBar.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/16.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

protocol PPToastNavigationBarDelegate {
    func toastNavigationBarDidClickDismissButton(_ toastNavigationBar: PPToastNavigationBar)
}

class PPToastNavigationBar: UIView {
    
    let barTitle = UILabel()
    let dismissBtn = UIButton(type: .system)
    
    var delegate: PPToastNavigationBarDelegate?

    init() {
        super.init(frame: CGRect())
        
        backgroundColor = .navigatorBlack
        
        barTitle.text = "New File"
        barTitle.textColor = .titleWhite
        barTitle.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        addSubview(barTitle)
        barTitle.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.bottom.equalTo(-12)
            make.height.equalTo(44)
            make.left.equalTo(28)
        }
        
        dismissBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        dismissBtn.tintColor = .activeGreen
        addSubview(dismissBtn)
        dismissBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.top.equalTo(20)
            make.bottom.equalTo(-14)
            make.right.equalTo(-17)
        }
        
        dismissBtn.addTarget(self, action: #selector(dismissBtnClicked(sender:)), for: .touchUpInside)
    }
    
    @objc func dismissBtnClicked(sender: UIButton) {
        delegate?.toastNavigationBarDidClickDismissButton(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
