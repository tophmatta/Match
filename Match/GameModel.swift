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
        
        // Generate card obj
        for index in 0...7 {
            
            // Generating random number
            var randNumber:Int = Int(arc4random_uniform(13))
            
            // Generating a new card object
            var firstCard:Card = Card()
            firstCard.cardValue = randNumber
            
            // Create second card object
            var secondCard:Card = Card()
            secondCard.cardValue = randNumber
            
            // Place card objects into the array
            generatedCards += [firstCard, secondCard]
        }
        // Randomize the cards
        for index in 0...generatedCards.count-1 {
            
            // Current card
            var currentCard:Card = generatedCards[index]
            
            // Randomly choose another index
            var randomIndex:Int = Int(arc4random_uniform(16))
            
            // Swap objects at the two indexes
            generatedCards[index] = generatedCards[randomIndex]
            generatedCards[randomIndex] = currentCard
            
            println(String(format:"swapping card %d with card %d", index, randomIndex))
            
        }
        
        return generatedCards
        
    }
   
}
 