//
//  RecipeIndregientsCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/6/21.
//

import UIKit

class RecipeIngredientsCell: UITableViewCell {

    @IBOutlet weak var IngredientsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setUpCell(ingredients: String){
        let attributedString = NSMutableAttributedString(string: ingredients)

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label **
        
        IngredientsLabel.attributedText = attributedString
        
        IngredientsLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
