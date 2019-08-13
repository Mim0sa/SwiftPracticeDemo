//
//  ViewController.swift
//  Creator
//
//  Created by 吉乞悠 on 2019/8/12.
//  Copyright © 2019 吉乞悠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = OptionBoardView(point: CGPoint(x: 20, y: 20), height: 100, numberOfOptions: 3)
        v.backgroundColor = .white
        view.addSubview(v)
        
        view.backgroundColor = .orange
        // Do any additional setup after loading the view.
    }


}

