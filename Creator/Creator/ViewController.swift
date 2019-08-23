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
        
        let p = ProgramBoardView(point: CGPoint(), width: 150, blockNum: 4)
        p.frame = CGRect(x: SCREENWIDTH - 170,
                         y: SCREENHEIGHT / 2 - p.frame.height / 2,
                         width: p.frame.width,
                         height: p.frame.height)
        view.addSubview(p)
        
        let o = OptionBoardView(point: CGPoint(), height: 150, options: [.Start,.Left,.Right,.Down,.Up])
        o.delegate = self
        o.frame = CGRect(x: SCREENWIDTH / 2 - o.frame.width / 2,
                         y: 20,
                         width: o.frame.width,
                         height: o.frame.height)
        view.addSubview(o)
        
    }

}

extension ViewController: OptionBoardViewDelegate {
    func optionBoardViewDidDrop(optionViewCenter: CGPoint) -> Bool {
        if optionViewCenter.x < 300 {
            return true
        } else {
            return false
        }
    }
}

