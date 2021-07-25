//
//  setUpTextView.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/25/21.
//

import Foundation
import UIKit
struct SetUpTextView{
    
    init() {
        
    }
    // put spacing between lines
    func setUpText(_ line: String) -> NSMutableAttributedString{
        
        let attributedString = NSMutableAttributedString(string: line)

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString
        
    }
}
