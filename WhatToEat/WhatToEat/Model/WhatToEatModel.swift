//
//  WhatToEatModel.swift
//  WhatToEat
//
//  Created by 吉乞悠 on 2018/12/8.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import Foundation

struct WhatToEatModel {
    
    var indexOflastResult: Int?
    
    var randomFoodPool:[String] = ["麻辣香锅","麻辣烫","冒菜","面","汉堡",
                                   "炸鸡","馄饨饺子","咖喱饭","寿司","盖浇饭",
                                   "火锅","便利店","蛋糕","汤包","生煎",
                                   "牛排","沙拉","粥","烧烤","牛肉粉丝汤",
                                   "黄焖鸡米饭","沙县小吃","兰州拉面","小炒菜","炒饭"]
    
    mutating func getRandomResult() -> String {
        var randomIndex = randomFoodPool.count.arc4random
        if randomIndex == indexOflastResult {
            randomIndex = randomFoodPool.count + 1 - randomIndex
        }
        indexOflastResult = randomIndex
        print(indexOflastResult!)
        return randomFoodPool[indexOflastResult!]
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
