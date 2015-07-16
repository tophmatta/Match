//
//  ViewController.swift
//  Match
//
//  Created by Toph on 7/12/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var gameModel:GameModel = GameModel()
    var cards:[Card] = [Card]()
    var revealedCard:Card?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Get card from game model
        self.cards = self.gameModel.getCards()
        
        // Layout cards
        self.layoutCards()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func layoutCards() {
        
        var columnCounter:Int = 0
        var rowCounter:Int = 0
        
        // Loop through each card in the array
        for index in 0...self.cards.count-1 {
        
            // Place the card in the view and turn off translateautoresizingmask
            var thisCard:Card = self.cards[index]
            thisCard.setTranslatesAutoresizingMaskIntoConstraints(false)
            self.contentView.addSubview(thisCard)
            
            var tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("cardTapped:"))
            thisCard.addGestureRecognizer(tapGestureRecognizer)
        
        
            // Set the height and width constraints
            var heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: thisCard, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 170)
        
            var widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: thisCard, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 120)
        
            thisCard.addConstraints([heightConstraint, widthConstraint])
        
            // Set the horiz position
            if (columnCounter > 0) {
                // Card is not in the first column
                var cardOnTheLeft:Card = self.cards[index-1]
                
                var leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: thisCard, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: cardOnTheLeft, attribute: NSLayoutAttribute.Right, multiplier: 1, constant: 5)
                
                self.contentView.addConstraint(leftMarginConstraint)
            }
            else {
                // Card is in the first column
                var leftMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: thisCard, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
                
                // Add constraint
                self.contentView.addConstraint(leftMarginConstraint)
            }
            
            // Set the vert position
            if (rowCounter > 0) {
                // Card is not in the first row
                var cardOnTop:Card = self.cards[index-4]
                
                var topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: thisCard, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: cardOnTop, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 5)
                
                // Add the constraint
                self.contentView.addConstraints([topMarginConstraint])
                
            }
            else {
                // Card is in the first row
                var topMarginConstraint:NSLayoutConstraint = NSLayoutConstraint(item: thisCard, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 10)
                
                // Add constraint
                self.contentView.addConstraints([topMarginConstraint])
                
            }
                
                
                // Set the position constraints relative to surrounding cards
                
                // Increment the counter if the column reaches the fifth column, reset it and increment the row counter
                columnCounter++
                if (columnCounter >= 4) {
                    columnCounter = 0
                    rowCounter++
                }
        } // end for loop
        
        // Add height constraint to content view so that the scrollview knows how much to allow to scroll
        var contentViewHeightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.cards[0], attribute: NSLayoutAttribute.Height, multiplier: 4, constant: 35)
        
        // Add constraint
        self.contentView.addConstraints([contentViewHeightConstraint])

    } // end layout func
    
    func cardTapped(recognizer:UITapGestureRecognizer) {
        
        // Get the card that was tapped
        var cardThatWasTapped:Card = recognizer.view as Card
        
        // Is the card already flipped up?
        if (cardThatWasTapped.isFlipped == false) {
            
            // Card is not flipped up, check if its the first card flipped
            if (self.revealedCard == nil) {
                
                // This is the first card being flipped
                // Flip down all of the cards
                self.flipDownAllCards()
                
                // Flip up the card
                cardThatWasTapped.flipUp()
                
                // Set the revealed card 
                self.revealedCard = cardThatWasTapped
            }
            else {
                // This is the second card being flipped
                
                // Flip up the card
                cardThatWasTapped.flipUp()
                
                // Check if card a match
                if (revealedCard?.cardValue == cardThatWasTapped.cardValue) {
                    
                    // It's a match
                    
                    // Remove both cards
                    self.revealedCard?.isDone = true
                    cardThatWasTapped.isDone = true
                    
                    // Reset revealed card
                    self.revealedCard = nil
                }
                else{
                    // It's not a match
                    
                    // Reset the revealed card
                    self.revealedCard = nil
                }
            }
            
        }
        
    } // end func cardTapped
    
    func flipDownAllCards() {
        
        for card in self.cards {
            
            if (card.isDone == false){
                
                card.flippedDown()
            }
        }
    }
} 

