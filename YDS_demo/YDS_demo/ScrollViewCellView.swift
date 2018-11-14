//
//  ContentCell.swift
//  YDS_demo
//
//  Created by 吉乞悠 on 2018/11/13.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import Foundation
import UIKit

class ContentCellView: UIView {
    
    let imageView = UIImageView(frame: CGRect(x: 4, y: 8, width: 117, height: 117))
    let deleteBtn = UIButton(frame: CGRect(x: 92, y: 7, width: 18, height: 18))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
    
        self.addSubview(imageView)
        
        deleteBtn.setImage(UIImage(named: "delete"), for: .normal)
        imageView.addSubview(deleteBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ButtonCellView: UIView {
    
    let btnView = UIButton(frame: CGRect(x: 4, y: 8, width: 117, height: 117))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        btnView.layer.cornerRadius = 10
        btnView.layer.masksToBounds = true
        self.addSubview(btnView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
