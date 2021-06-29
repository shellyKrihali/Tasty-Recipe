//
//  CustomButton.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/29/21.
//

import UIKit

class CustomButton: UIButton {
    
    //frist loading func
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetUp()
    }
    
    //first required loading func
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetUp()
    }
    
    //customize the button to orange background
    func defaultSetUp(){
        let orange = CustomColor(withFrame: frame).getOrangeColor()
        layer.backgroundColor = orange.cgColor
        layer.cornerRadius = layer.frame.height/2
        layer.masksToBounds = true
        //login spacing
        let spacing = 3
        let buttonAttributedString = NSMutableAttributedString(string: (titleLabel?.text)!)
        buttonAttributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, buttonAttributedString.length))
        self.setAttributedTitle(buttonAttributedString, for: .normal)
    }
    
    func makeCustomWhiteButton(){
        let orange = CustomColor(withFrame: frame).getOrangeColor()
        //signup button
        layer.borderColor = orange.cgColor
        layer.borderWidth = 2
        backgroundColor = .white
        layer.cornerRadius = layer.frame.height/2
        layer.masksToBounds = true
        //spacing
        let signUSpacing = 3
        let signUpSpacingButtonAttributedString = NSMutableAttributedString(string: (titleLabel?.text)!)
        signUpSpacingButtonAttributedString.addAttribute(NSAttributedString.Key.kern, value: signUSpacing, range: NSMakeRange(0, signUpSpacingButtonAttributedString.length))
        self.setAttributedTitle(signUpSpacingButtonAttributedString, for: .normal)
        
    }
}
