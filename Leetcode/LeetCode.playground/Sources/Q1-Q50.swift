import Foundation

extension LeetCodeSupport {
    // MARK: - Q1

    // MARK: - Q7

    // MARK: - Q9

    // MARK: - Q13
    func romanToInt(_ s: String) -> Int {
        let valueDic: [Character:Int] = ["I":1, "V":5, "X":10,
                                         "L":50, "C":100,
                                         "D":500, "M":1000]
        
        var lastcValue = 0
        var value = 0
        
        for c in s {
            if valueDic[c]! > lastcValue {
                value = value + valueDic[c]! - 2 * lastcValue
            } else {
                value += valueDic[c]!
            }
            lastcValue = valueDic[c]!
        }
        
        return value
    }
    
    // MARK: - Q14
    func longestCommonPrefix(_ strs: [String]) -> String {
        return ""
    }
    
}






