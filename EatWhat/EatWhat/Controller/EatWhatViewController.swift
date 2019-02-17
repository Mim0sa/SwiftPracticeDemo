//
//  EatWhatViewController.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/12.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class EatWhatViewController: UIViewController {

    @IBOutlet private weak var eatWhatLbl: UILabel!
    
    @IBOutlet weak var eatWhatBtn: EatWhatButton!
    
    private(set) var textForLbl: String = "????" { didSet { eatWhatLbl.text = textForLbl } }
    
    private var eatWhatTimer: Timer?
    
    private var eatWhatModel = EatWhatModel()
  
    @objc private func updateEatWhatLbl(){ textForLbl = eatWhatModel.getRandomResult() }
    
    @IBAction private func touchDown(_ sender: EatWhatButton) {
        sender.status = .selected
        
        eatWhatTimer = Timer.scheduledTimer(timeInterval: 0.1,target: self,
                                            selector: #selector(updateEatWhatLbl),
                                            userInfo: nil,repeats: true)
        eatWhatTimer!.fire()
    }
    
    @IBAction private func touchUpInside(_ sender: EatWhatButton) { touchUp(sender) }
    
    @IBAction private func touchUpOutside(_ sender: EatWhatButton) { touchUp(sender) }
    
    private func touchUp(_ sender: EatWhatButton){
        sender.status = .normal
        
        stopEatWhatTimer()
    }
    
    func stopEatWhatTimer(){
        if eatWhatTimer != nil {
            eatWhatTimer!.invalidate()
            eatWhatTimer = nil
        }
    }
    
}

