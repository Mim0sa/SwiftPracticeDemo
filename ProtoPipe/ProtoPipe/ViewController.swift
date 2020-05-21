//
//  ViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/6.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit
import SnapKit

class PPViewController: PPBaseViewController {

    lazy var box = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(box)
        box.backgroundColor = .orange
        box.snp.makeConstraints { (make) -> Void in
           make.width.height.equalTo(200)
           make.center.equalTo(self.view)
        }
    }

}

