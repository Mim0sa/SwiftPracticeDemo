//
//  EatWhatViewController.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/12.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import UIKit

class EatWhatViewController: UIViewController {
    
    private var eatWhatPool: [String] =
        [" 麻辣香锅🥘","麻辣烫","冒菜"," 面条🍝"," 汉堡🍔",
         " 炸鸡🍗"," 馄饨饺子🥟"," 咖喱饭🍛"," 寿司🍣"," 简餐🍱",
         " 火锅🍲"," 便利店🏪"," 蛋糕🍰"," 汤包生煎"," 披萨🍕",
         " 牛排🥩"," 沙拉🥗"," 三明治🥪"," 烧烤🍺"," 烤肉🍖",
         " 黄焖鸡米饭🍚","沙县小吃"," 兰州拉面🍜"," 西餐🍸"," 炒菜🍳"]//temporary
    
    lazy private var eatWhatModel = EatWhatModel(with: eatWhatPool)

    @IBOutlet private weak var eatWhatLbl: UILabel!
    
    private(set) var textForLbl: String = "" { didSet { eatWhatLbl.text = textForLbl } }
    
    private var eatWhatTimer: Timer?
    
    @IBAction private func touchDown(_ sender: EatWhatButton) {
        sender.setTitle("松手停止", for: .normal)
        
        eatWhatTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateEatWhatLbl), userInfo: nil, repeats: true)
        eatWhatTimer!.fire()
    }
    
    @objc private func updateEatWhatLbl(){
        textForLbl = eatWhatModel.getRandomResult()
    }
    
    @IBAction private func touchUpInside(_ sender: EatWhatButton) {
        sender.setTitle("再来一次", for: .normal)
        
        stopEatWhatTimer()
    }
    
    @IBAction private func touchUpOutside(_ sender: EatWhatButton) {
        sender.setTitle("再来一次", for: .normal)
        
        stopEatWhatTimer()
    }
    
    func stopEatWhatTimer(){
        if eatWhatTimer != nil {
            eatWhatTimer!.invalidate()
            eatWhatTimer = nil
        }
    }
    
}

