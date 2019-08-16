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
        
        let v = OptionBoardView(point: CGPoint(), height: 150, options: [.Start,.Left,.Right,.Down,.Up])
        v.frame = CGRect(x: SCREENWIDTH / 2 - v.frame.width / 2,
                         y: 20,
                         width: v.frame.width,
                         height: v.frame.height)
        view.addSubview(v)
        
        
    }


}

