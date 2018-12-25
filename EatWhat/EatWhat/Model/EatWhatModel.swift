//
//  EatWhatModel.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/12.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import Foundation

struct EatWhatModel {
    
    private(set) var indexOflastResult: Int?
    
    var eatWhatPool: [String] =
        [" 麻辣香锅🥘"," 麻辣烫🌶"," 肉蟹煲🦀"," 面条🍝"," 汉堡🍔",
         " 炸鸡🍗"," 馄饨饺子🥟"," 咖喱饭🍛"," 寿司🍣"," 简餐🍱",
         " 火锅🍲"," 便利店🏪"," 蛋糕🍰"," 海鲜🦞"," 披萨🍕",
         " 牛排🥩"," 沙拉🥗"," 三明治🥪"," 烧烤🍺"," 烤肉🍖",
         " 黄焖鸡米饭🍚"," 沙县小吃🥧"," 兰州拉面🍜"," 西餐🍽"," 面包🥐"]//initial
    
    mutating func getRandomResult() -> String {
        var randomIndex = eatWhatPool.count.arc4random
        if randomIndex == indexOflastResult {
            randomIndex = eatWhatPool.count - 1 - randomIndex
        }
        indexOflastResult = randomIndex
        return eatWhatPool[indexOflastResult!]
    }
    
    mutating func setNewPool(with newPool: [String]){
        eatWhatPool = newPool
    }
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
