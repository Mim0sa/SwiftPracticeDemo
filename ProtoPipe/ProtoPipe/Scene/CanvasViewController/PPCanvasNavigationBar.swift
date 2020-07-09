//
//  PPCanvasNavigationBar.swift
//  ProtoPipe
//
//  Created by CM on 2020/7/8.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

protocol PPCanvasNavigationBarDelegate: class {
    func canvasNavigationBarDidClickBackBtn(_ canvasNavigationBar: PPCanvasNavigationBar)
}

class PPCanvasNavigationBar: UIView {
    
    weak var delegate: PPCanvasNavigationBarDelegate?

    init() {
        super.init(frame: CGRect())
        
        backgroundColor = .navigatorBlack
        
        for i in 0...4 {
            let btn = PPBarItemButton()
            btn.setImage(UIImage(named: "lib"), for: .normal)
            btn.imageView?.contentMode = .scaleAspectFit
            btn.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.bottom.equalTo(-10)
                make.right.equalTo(-12 + i * -70)
            }
        }
        
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
