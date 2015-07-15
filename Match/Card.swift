//
//  Card.swift
//  Match
//
//  Created by Toph on 7/12/15.
//  Copyright (c) 2015 Toph. All rights reserved.
//

import UIKit

class Card: UIView {
    
    var CardImageView:UIImageView = UIImageView()
    var cardValue:Int = 0
    var cardNames:[String] = ["ace", "card2", "card3", "card4", "card5", "card6", "card7", "card8", "card9", "card10", "jack", "queen", "king"]
    
    override init() {
        super.init()
        
        self.backgroundColor = UIColor.redColor()
        
        // To Do: set default img for img view
        // To Do: add img view to view
        // To Do: set contraints for the img view
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

}
