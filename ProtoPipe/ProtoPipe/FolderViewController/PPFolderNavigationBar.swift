//
//  PPFolderNavigationBar.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/22.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

class PPFolderNavigationBar: UIView {

    let barIcon: UIButton = UIButton(type: .system)
    var barItems: [UIButton] = []
    
    init() {
        super.init(frame: CGRect())
        
        backgroundColor = UIColor(withHex: 0x131415)
        
        barIcon.setTitle("ProtoPipe", for: .normal)
        barIcon.titleLabel?.font = UIFont.systemFont(ofSize: 44, weight: .heavy)
        barIcon.tintColor = UIColor(withHex: 0xeeeeee)
        barIcon.sizeToFit()
        addSubview(barIcon)
        
        let barItem_new = UIButton(type: .system)
        barItem_new.setTitle("New", for: .normal)
        barItem_new.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        barItem_new.tintColor = UIColor(withHex: 0xeeeeee)
        barItem_new.sizeToFit()
        barItems.append(barItem_new)
        addSubview(barItem_new)
        
        let barItem_select = UIButton(type: .system)
        barItem_select.setTitle("Select", for: .normal)
        barItem_select.titleLabel?.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        barItem_select.tintColor = UIColor(withHex: 0xeeeeee)
        barItem_select.sizeToFit()
        barItems.append(barItem_select)
        addSubview(barItem_select)
        
        barIcon.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.bottom.equalTo(0)
        }
        
        barItems[0].snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.bottom.equalTo(-5)
        }
        
        barItems[1].snp.makeConstraints { (make) in
            make.right.equalTo(barItems[0].snp.left).offset(-20)
            make.bottom.equalTo(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
