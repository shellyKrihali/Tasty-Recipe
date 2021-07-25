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
        let setuptext = SetUpTextView()
        
        instructionsLabel.attributedText = setuptext.setUpText(instructions)
        
        instructionsLabel.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
