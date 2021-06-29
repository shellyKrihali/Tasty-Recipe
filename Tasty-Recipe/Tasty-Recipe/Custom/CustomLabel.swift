//
//  CustomLabel.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/29/21.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetUp()
        
    }
    
    //first required to load
    required init?(coder aDecoder: NSCoder ) {
        super.init(coder: aDecoder)
        defaultSetUp()
    }
    
    func defaultSetUp(){
        //label spacing
        let labelSpace = 1
        let labelAttributeString = NSMutableAttributedString(string: text!)
        labelAttributeString.addAttribute(NSAttributedString.Key.kern, value: labelSpace, range: NSMakeRange(0, labelAttributeString.length))
        attributedText = labelAttributeString
        
    }
    //sets the spacing of text
    func setSpacing(space: CGFloat){
        let labelAttributeString = NSMutableAttributedString(string: text!)
        labelAttributeString.addAttribute(NSAttributedString.Key.kern, value: space, range: NSMakeRange(0, labelAttributeString.length))
        attributedText = labelAttributeString
        
    }

}
