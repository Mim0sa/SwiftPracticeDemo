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
    
    var indexOfOneAndOnlyFaceUpCard :Int?
    
    func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //only 1 card face up
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
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
