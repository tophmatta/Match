//
//  Card.swift
//  Match
//
//  Created by Toph on 7/12/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class Card: UIView {
    
    var cardImageView:UIImageView = UIImageView()
    var cardValue:Int = 0
    var cardNames:[String] = ["ace", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king"]
    var isFlipped:Bool = false
    
    override init() {
        super.init()
        
        // Set default img for img view
        self.cardImageView.image = UIImage(named: "back")
        
        // Set translate autoresizingmask to false
        self.cardImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        // Add img view to view
        self.addSubview(self.cardImageView)
        
        // Set contraints for the img view
        var heightConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.cardImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 170)
        
        var widthConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.cardImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 120)
        
        self.cardImageView.addConstraints([heightConstraint, widthConstraint])
        
        //set position of image view
        var verticalConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.cardImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        var horizontalConstraint:NSLayoutConstraint = NSLayoutConstraint(item: self.cardImageView, attribute: NSLayoutAttribute.Left, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Left, multiplier: 1, constant: 0)
        
        self.addConstraints([verticalConstraint, horizontalConstraint])
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
    }
    
    func flipUp() {
        // Set imgview to image that represents the card value
        self.cardImageView.image = UIImage(named: self.cardNames[self.cardValue])
        
        self.isFlipped = true
    }

    func flippedDown() {
        // Set the imageview to the card back
        self.cardImageView.image = UIImage(named: "back")
        
        self.isFlipped = false
    }
}
