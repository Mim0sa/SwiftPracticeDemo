//
//  PPToastView.swift
//  ProtoPipe
//
//  Created by CM on 2020/6/18.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

protocol PPToastViewDelegate {
    func toastViewDidClickOKButton(_ toastView: PPToastView)
}

class PPToastView: UIView {
    
    var delegate: PPToastViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
