//
//  CategoryCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/1/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    	
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
        print("I----")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        print("INSIDE SET SELECTED")
        // Configure the view for the selected state
        //print(categoryLabel.text)
        //here add recipes cells with the same category name
        
    }
    

}
