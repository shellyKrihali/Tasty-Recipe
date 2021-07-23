//
//  RecipeInstructionsCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/6/21.
//

import UIKit

class RecipeInstructionsCell: UITableViewCell {

    @IBOutlet weak var instructionsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setUpCell(instructions: String){
        
        let attributedString = NSMutableAttributedString(string: instructions)

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label **
        
        instructionsLabel.attributedText = attributedString
        instructionsLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
