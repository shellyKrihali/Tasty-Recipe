//
//  FeatureCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/1/21.
//

import UIKit

class FeatureCell: UITableViewCell {

    @IBOutlet weak var viewCollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
