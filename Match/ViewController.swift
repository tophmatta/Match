//
//  ViewController.swift
//  Match
//
//  Created by Toph on 7/12/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var cardScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    var gameModel:GameModel = GameModel()
    var cards:[Card] = [Card]()
    var revealedCard:Card?
    
    // Timer properties
    var timer:NSTimer!
    var countdown:Int = 30
   @IBOutlet weak var countdownLabel: UILabel!
    
    // Audio player properties
    var correctSoundPlayer:AVAudioPlayer?
    var wrongSoundPlayer:AVAudioPlayer?
    var shuffleSoundPlayer:AVAudioPlayer?
    var flipSoundPlayer:AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Initialize the audio player
        var correctSoundUrl:NSURL? = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dingcorrect", ofType: "wav")!)
        if (correctSoundUrl) != nil {
            self.correctSoundPlayer = AVAudioPlayer(contentsOfURL: correctSoundUrl!, error: nil)
        }
        
        var wrongSoundUrl:NSURL? = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dingwrong", ofType: "wav")!)
        if (wrongSoundUrl != nil) {
            self.wrongSoundPlayer = AVAudioPlayer(contentsOfURL: wrongSoundUrl!, error: nil)
        }
        
        var shuffleSoundUrl:NSURL? = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("shuffle", ofType: "wav")!)
        if (shuffleSoundUrl != nil) {
            self.shuffleSoundPlayer = AVAudioPlayer(contentsOfURL: shuffleSoundUrl!, error: nil)
        }
        
        var flipSoundUrl:NSURL? = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cardflip", ofType: "wav")!)
        if (flipSoundUrl != nil) {
            self.flipSoundPlayer = AVAudioPlayer(contentsOfURL: flipSoundUrl!, error: nil)
        }
        
        // Get card from game model
        self.cards = self.gameModel.getCards()
        
        // Layout cards
        self.layoutCards()
        
        // Play the shuffle sound
        if  (self.shuffleSoundPlayer != nil){
            self.shuffleSoundPlayer?.play()
        }
        
        // Start the timer
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerUpdate"), userInfo: nil, repeats: true)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerUpdate () {
        
        // Decrement the counter
        countdown--
        
        // Update countdown label
        self.countdownLabel.text = String(countdown)
        
        if (countdown == 0){
            
            // Stop the timer
            self.timer.invalidate()
            
            // Game is over, check if there is at least one unmatched card
            var allCardsMatched:Bool = true
            
            for card in self.cards {
                
                if (card.isDone == false){
                    allCardsMatched = false
                    break;
                }
            }
            var alertText:String = ""
            if (allCardsMatched == true){
                
                // Win
                alertText = "You Win!"
            }
            else{
                
                //Lose
                alertText = "You Lose!"
            }
            
            var alert:UIAlertController = UIAlertController(title: "Time's Up", message: alertText, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
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
        
        // If countdown is 0, then exit
        if (self.countdown == 0 ) {
            return
        }
        
        // Get the card that was tapped
        var cardThatWasTapped:Card = recognizer.view as! Card
        
        // Is the card already flipped up?
        if (cardThatWasTapped.isFlipped == false) {
            
            if (flipSoundPlayer != nil) {
                self.flipSoundPlayer?.play()
            }
            
            // Card is not flipped up, check if its the first card flipped
            if (self.revealedCard == nil) {
                
                // This is the first card being flipped
                // Flip down all of the cards
                //self.flipDownAllCards()
                
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
                    
                    // Play correct sound
                    if (self.correctSoundPlayer != nil) {
                        self.correctSoundPlayer?.play()
                    }
                    
                    // Remove both cards
                    self.revealedCard?.isDone = true
                    cardThatWasTapped.isDone = true
                    
                    // Reset revealed card
                    self.revealedCard = nil
                }
                else{
                    // It's not a match
                    
                    // Play wrong sound
                    if (wrongSoundPlayer != nil) {
                        self.wrongSoundPlayer?.play()
                    }
                    
                    // Flip down both cards
                    
                    var timer1 = NSTimer.scheduledTimerWithTimeInterval(1, target: self.revealedCard!, selector: Selector("flippedDown"), userInfo: nil, repeats: false)
                    
                    var timer2 = NSTimer.scheduledTimerWithTimeInterval(1, target: cardThatWasTapped, selector: Selector("flippedDown"), userInfo: nil, repeats: false)
                    
                    
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

