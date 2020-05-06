//
//  ViewController.swift
//  ProtoPipe
//
//  Created by 吉乞悠 on 2020/5/6.
//  Copyright © 2020 吉乞悠. All rights reserved.
//

import UIKit

import SnapKit

class ViewController: UIViewController {

    lazy var box = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(box)
        box.backgroundColor = .green
        box.snp.makeConstraints { (make) -> Void in
           make.width.height.equalTo(50)
           make.center.equalTo(self.view)
        }
    }

}

