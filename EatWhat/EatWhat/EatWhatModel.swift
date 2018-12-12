//
//  EatWhatModel.swift
//  EatWhat
//
//  Created by 吉乞悠 on 2018/12/12.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import Foundation

struct EatWhatModel {
    
    private(set) var eatWhatPool: [String]
    
    private(set) var indexOflastResult: Int?
    
    init(with initialPool: [String]) {
        eatWhatPool = initialPool
    }
    
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
