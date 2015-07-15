//
//  GameModel.swift
//  Match
//
//  Created by Toph on 7/12/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class GameModel: NSObject {
    
    func getCards () -> [Card] {
        
        var generatedCards:[Card] = [Card]()
        
        // to do: generate card obj
        for index in 0...7 {
            
            // generating random number
            var randNumber:Int = Int(arc4random_uniform(13))
            
            // generating a new card object
            var firstCard:Card = Card()
            firstCard.cardValue = randNumber
            
            // create second card object
            var secondCard:Card = Card()
            secondCard.cardValue = randNumber
            
            // place card objects into the array
            generatedCards += [firstCard, secondCard]
        }
        // randomize the cards
        for index in 0...generatedCards.count-1 {
            
            // current card
            var currentCard:Card = generatedCards[index]
            
            // randomly choose another index
            var randomIndex:Int = Int(arc4random_uniform(16))
            
            // swap objects at the two indexes
            generatedCards[index] = generatedCards[randomIndex]
            generatedCards[randomIndex] = currentCard
            
            println(String(format:"swapping card %d with card %d", index, randomIndex))
            
        }
        
        return generatedCards
        
    }
   
}
 