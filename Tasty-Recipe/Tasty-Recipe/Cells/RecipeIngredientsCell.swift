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
        IngredientsLabel.text = ingredients
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
