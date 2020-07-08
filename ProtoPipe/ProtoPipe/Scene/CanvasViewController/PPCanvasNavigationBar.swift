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
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
}
