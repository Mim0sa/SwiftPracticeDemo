//
//  PPCanvasViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

protocol PPCanvasViewControllerDelegate: class {
    func canvasViewControllerDidClickedFolderButton(_ vc: PPCanvasViewController)
}

class PPCanvasViewController: PPBaseViewController {
    
    let canvasNavigationBar = PPCanvasNavigationBar()
    
    weak var delegate: PPCanvasViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .sceneBlack
    
        canvasNavigationBar.delegate = self
        view.addSubview(canvasNavigationBar)
        canvasNavigationBar.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(56)
        }
    }
    
}

// MARK: - PPCanvasNavigationBarDelegate
extension PPCanvasViewController: PPCanvasNavigationBarDelegate {
    func canvasNavigationBarDidClickBackBtn(_ canvasNavigationBar: PPCanvasNavigationBar) {
        
    }
}
