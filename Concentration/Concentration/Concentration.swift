//
//  Concentration.swift
//  Concentration
//
//  Created by 吉乞悠 on 2018/11/16.
//  Copyright © 2018 吉乞悠. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard :Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if foundIndex == nil {
                    foundIndex = index
                } else {
                    return nil
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)):chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //only 1 card face up
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)):you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card,card]
        }
        //TODO shuffle the cards
        var tempCards = [Card]()
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            tempCards.append(cards.remove(at: randomIndex))
        }
        cards = tempCards
    }
    
}
