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
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUpCell(recipe: Recipe){
        loadImage(recipe: recipe)
        recipeNameLabel.text! = recipe.name!
        servingLabel.text! = String(recipe.serving!) + " people"
        timetocookLabel.text! = String(recipe.timeInMinutes!) + " min"
        levelOfCookingLabel.text! = recipe.levelOfCooking!
    }
    //show imageUI after converting the url image
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
