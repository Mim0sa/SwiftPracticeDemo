//
//  PPCanvasViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/21.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

protocol PPCanvasViewControllerDelegate {
    func canvasViewControllerDidClickedFolderButton(vc: PPCanvasViewController)
}

class PPCanvasViewController: PPBaseViewController {

    lazy var box = UIButton()
    
    var delegate: PPCanvasViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple

        self.view.addSubview(box)
        box.backgroundColor = .lightGray
        box.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        box.snp.makeConstraints { (make) -> Void in
           make.width.height.equalTo(50)
           make.center.equalTo(self.view)
        }
    }

    @objc func buttonClicked(sender: UIButton) {
        if let delegate = delegate {
            delegate.canvasViewControllerDidClickedFolderButton(vc: self)
        }
    }
    
}
