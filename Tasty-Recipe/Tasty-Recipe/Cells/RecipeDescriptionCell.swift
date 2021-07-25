//
//  RecipeDescriptionCell.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/6/21.
//

import UIKit

class RecipeDescriptionCell: UITableViewCell {
    
    var currentRecipe = Recipe()
    let manager = Manager()
    
    @IBOutlet weak var recipeImageDes: UIImageView!
    
    @IBOutlet weak var recipeLevelOfCookingDes: UILabel!
    
    @IBOutlet weak var recipeTimetoCookDes: UILabel!
    
    @IBOutlet weak var recipeServingDes: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton.imageEdgeInsets = UIEdgeInsets(top: 30,left: 30,bottom: 30,right: 30)
        heartButton.frame = CGRect(x: 0, y:0, width: 30, height: 30)
        
    }
    // heart button tapped
    @IBAction func handleMarkAsFavorite(_ sender: Any) {
        manager.loadFavoriteStatus(recipe: currentRecipe){ flag in
            self.manager.loadRecipeToFavorites(recipe: self.currentRecipe)
            if(!flag){
                //paint red
                UserDefaults.standard.set(0, forKey: "remove")
                self.heartButton.setImage(UIImage(named: "ic_favorites_orange.png"), for: .normal)
                self.manager.loadRecipeToFavorites(recipe: self.currentRecipe)
                self.reloadInputViews()
            }else{
                //paint gray
                self.heartButton.setImage(UIImage(named: "ic_favorites_grey.png"), for: .normal)
                //if recipes.count == 1, remove and put no recipes yet view
                UserDefaults.standard.set(1, forKey: "remove")
                
                self.manager.removeRecipeFromFavorites(recipe: self.currentRecipe)
                
                self.reloadInputViews()
            }
        }
    }
    
    func setUpCell(_ recipe:Recipe){
        currentRecipe = recipe
        loadImage(recipe: recipe)
        self.recipeLevelOfCookingDes.text = recipe.levelOfCooking
        self.recipeServingDes.text = String(recipe.serving!) + " People"
        self.recipeTimetoCookDes.text = String(recipe.timeInMinutes!) + " min"
        
        //check if recipe is added to favorites
        manager.loadFavoriteStatus(recipe: currentRecipe)
        {
            flag in
            if(flag){
                // the heart is orange
                self.heartButton.setImage(UIImage(named: "ic_favorites_orange.png"), for: .normal)
            }else{
                // the heart is white
                self.heartButton.setImage(UIImage(named: "ic_favorites_grey.png"), for: .normal)
            }
        }
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
        super.setSelected(selected, animated: true)
    }
    
}
