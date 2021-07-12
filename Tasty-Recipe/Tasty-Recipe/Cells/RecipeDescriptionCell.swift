//
//  RecipeDescriptionCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/6/21.
//

import UIKit

class RecipeDescriptionCell: UITableViewCell {

    
    var currentRecipe = Recipe()
    var hasFavoritePressedAlready : Bool = false
    @IBOutlet weak var recipeNameDes: UILabel!
    @IBOutlet weak var recipeImageDes: UIImageView!
    
    @IBOutlet weak var recipeLevelOfCookingDes: UILabel!
    
    
    @IBOutlet weak var recipeTimetoCookDes: UILabel!
    @IBOutlet weak var recipeServingDes: UILabel!
    
    
    @IBOutlet weak var heartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heartButton.frame = CGRect(x: 0, y:0, width: 50, height: 50)
        heartButton.tintColor = .red
        heartButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
    }
    @objc private func handleMarkAsFavorite(){
        let manager = Manager()
        manager.loadFavoriteStatus(recipe: currentRecipe){ flag in
            print(flag)
            self.hasFavoritePressedAlready = flag
            manager.loadRecipeToFavorites(recipe: self.currentRecipe)
            if(!self.hasFavoritePressedAlready){
                //paint red
                self.heartButton.setImage(UIImage(named: "ic_favorites_orange.png"), for: .normal)
                manager.loadRecipeToFavorites(recipe: self.currentRecipe)
                self.hasFavoritePressedAlready = true
                self.reloadInputViews()
            }else{
                //paint gray
                self.heartButton.setImage(UIImage(named: "ic_favorites_grey.png"), for: .normal)
                manager.removeRecipeFromFavorites(recipe: self.currentRecipe)
                self.reloadInputViews()
            }
        }
            
    }
    func setUpCell(_ recipe:Recipe){
        currentRecipe = recipe
        loadImage(recipe: recipe)
        self.recipeNameDes.text = recipe.name
        self.recipeLevelOfCookingDes.text = recipe.levelOfCooking
        self.recipeServingDes.text = String(recipe.serving!) + " People"
        self.recipeTimetoCookDes.text = String(recipe.timeInMinutes!) + " min"
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
                self.recipeImageDes.image = downloadedImage
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
