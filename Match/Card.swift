//
//  Card.swift
//  Match
//
//  Created by Toph on 7/12/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class Card: UIView {
    
    var frontImageView:UIImageView = UIImageView()
    var backImageView:UIImageView = UIImageView()
    var cardValue:Int = 0
    var cardNames:[String] = ["card1", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "card11", "card12", "card13"]
    var isFlipped:Bool = false
    var isDone:Bool = false {
        
        didSet {
          // If the card is done, remove the image
            if (isDone == true){
                
                UIView.animateWithDuration(1, delay: 1, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                    
                    self.frontImageView.alpha = 0
                    self.backImageView.alpha = 0
                    
                    }, completion: nil)
                
            }
        }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        // call UI views with fram method and pass in the frame
        super.init(frame: frame)
        
        // Set default img for img view
        self.backImageView.image = UIImage(named: "back")
        self.applySizeConstraintsToImage(backImageView)
        self.applyPositioningConstraintsToImage(backImageView)
        
        // Set autolayout constraints for the fron
        self.applySizeConstraintsToImage(self.frontImageView)
        self.applyPositioningConstraintsToImage(self.frontImageView)
        
        

    }
    
    func applySizeConstraintsToImage(imageView:UIImageView) {
        
        // Set translate autoresizingmask to false
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add img view to view
        self.addSubview(imageView)
        
        // Set contraints for the img view
        var heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 170)
        
        var widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 120)
        
        imageView.addConstraints([heightConstraint, widthConstraint])
        
        
    }
    
    func applyPositioningConstraintsToImage(imageView:UIImageView) {
        
        //set position of image view
        var verticalConstraint:NSLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        var horizontalConstraint:NSLayoutConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        self.addConstraints([verticalConstraint, horizontalConstraint])
        
    }
    
    func flipUp() {
        // Set imgview to image that represents the card value
        self.frontImageView.image = UIImage(named: self.cardNames[self.cardValue])
        
        // Do animation
        UIView.transitionFromView(self.backImageView, toView: self.frontImageView, duration: 1/2, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        
        // Add positioning constraints
        self.applyPositioningConstraintsToImage(self.frontImageView)
        
        self.isFlipped = true
    }

    func flippedDown() {
        // Set the imageview to the card back
        UIView.transitionFromView(self.frontImageView, toView: self.backImageView, duration: 1/2
        , options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        
        // Add positioning constraints
        self.applyPositioningConstraintsToImage(self.backImageView)
        
        self.isFlipped = false
    }
}
