//
//  RecipeCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit

class RecipeCell: UITableViewCell {

    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var timetocookLabel: UILabel!
    
    @IBOutlet weak var levelOfCookingLabel: UILabel!
    
    @IBOutlet weak var servingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        //backgroundColor = .red
//        let starBurron = UIButton(type: .system)
//        starBurron.setTitle("SOME TITLE", for: .normal)
//        starBurron.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUpCell(recipe: Recipe){
        loadImage(recipe: recipe)
        recipeNameLabel.text! = recipe.name!
        servingLabel.text! = String(recipe.serving!) + " people"
        timetocookLabel.text! = String(recipe.timeInMinutes!) + " min"
        levelOfCookingLabel.text! = recipe.levelOfCooking!
        
    }
    func loadImage(recipe: Recipe){
        var downloadedImage = UIImage()
        guard let imageString = recipe.image else{return}
        guard let imageURL = URL(string: imageString) else {return}
        let imageProcessor  = NetworkProcessor(url: imageURL)
        imageProcessor.downloadImage{ (data,response, error) in
            DispatchQueue.main.async {
                guard let imageData = data else {return}
                downloadedImage = UIImage(data: imageData)!
                self.recipeImage.image = downloadedImage
            }
        }
    }

}
