//
//  ViewController.swift
//  WhatToEat
//
//  Created by 吉乞悠 on 2018/12/7.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var whatToEatBtn: WhatToEatButton!
    
    var whatToEatModel = WhatToEatModel()
    
    var whatToEatTimer : Timer?
    
    var titleForWTEBtn: String = "" {
        didSet {
            whatToEatBtn.setTitle(titleForWTEBtn, for: .normal)
        }
    }
    
    @IBAction func touchDown(_ sender: WhatToEatButton) {
        print("touch down")
        whatToEatTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateWTEBtnTitle), userInfo: nil, repeats: true)
        whatToEatTimer!.fire()
    }
    
    @IBAction func touchUpInside(_ sender: WhatToEatButton) {
        print("touch up inside")
        stopWTETimer()
    }
    
    @IBAction func touchUpOutside(_ sender: WhatToEatButton) {
        print("touch up outside")
        stopWTETimer()
    }
    
    func stopWTETimer(){
        if whatToEatTimer != nil {
            whatToEatTimer!.invalidate() //销毁timer
            whatToEatTimer = nil
        }
    }
    
    @objc func updateWTEBtnTitle(){
        titleForWTEBtn = whatToEatModel.getRandomResult()
    }
    
}

