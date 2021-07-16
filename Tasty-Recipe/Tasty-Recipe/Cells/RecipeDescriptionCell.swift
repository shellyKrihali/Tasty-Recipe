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
    let manager = Manager()

    @IBOutlet weak var recipeNameDes: UILabel!
    
    @IBOutlet weak var recipeImageDes: UIImageView!
    
    @IBOutlet weak var recipeLevelOfCookingDes: UILabel!
    
    
    @IBOutlet weak var recipeTimetoCookDes: UILabel!
    @IBOutlet weak var recipeServingDes: UILabel!
    
    
    @IBOutlet weak var heartButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        heartButton.imageEdgeInsets = UIEdgeInsets(top: 30,left: 30,bottom: 30,right: 30)
        heartButton.frame = CGRect(x: 0, y:0, width: 50, height: 50)
        heartButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
    }
    @objc private func handleMarkAsFavorite(){
        manager.loadFavoriteStatus(recipe: currentRecipe){ flag in
            self.manager.loadRecipeToFavorites(recipe: self.currentRecipe)
            if(!flag){
                //paint red
                self.heartButton.setImage(UIImage(named: "ic_favorites_orange.png"), for: .normal)
                self.manager.loadRecipeToFavorites(recipe: self.currentRecipe)
                self.reloadInputViews()
            }else{
                //paint gray
                self.heartButton.setImage(UIImage(named: "ic_favorites_grey.png"), for: .normal)
                self.manager.removeRecipeFromFavorites(recipe: self.currentRecipe)
                self.manager.loadFavorites(){_ in
                    
                }
                self.reloadInputViews()//maybe thats the bug
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
        manager.loadFavoriteStatus(recipe: currentRecipe)
        {
            flag in
            if(flag){
                self.heartButton.setImage(UIImage(named: "ic_favorites_orange.png"), for: .normal)
            }else{
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
