//
//  FavoritesTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class FavoritesTableViewController: UITableViewController {

    var recipes : [Recipe] = []
    let manager = Manager()
    override func viewDidLoad() {
        super.viewDidLoad()

        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
 
        self.clearsSelectionOnViewWillAppear = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
    manager.loadFavorites() { favoritesArray in
            self.recipes = favoritesArray
            self.tableView.reloadData()
        }
    }
    func openRecipe(index: Int){
        UserDefaults.standard.set(self.recipes[index].name, forKey: "name")
        UserDefaults.standard.set(self.recipes[index].timeInMinutes, forKey: "timeInMinutes")
        UserDefaults.standard.set(self.recipes[index].serving, forKey: "serving")
        UserDefaults.standard.set(self.recipes[index].image, forKey: "image")
        UserDefaults.standard.set(self.recipes[index].category, forKey: "category")
        UserDefaults.standard.set(self.recipes[index].ingredients, forKey: "ingredients")
        UserDefaults.standard.set(self.recipes[index].instructions, forKey: "instructions")
        UserDefaults.standard.set(self.recipes[index].levelOfCooking, forKey: "levelOfCooking")
        
        let storyboard :UIStoryboard = UIStoryboard(name: "RecipeDetail", bundle: nil)
        let recipeDetailViewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailViewController") as! RecipeDetailViewController
        self.present(recipeDetailViewController, animated: true, completion: nil)
        
        
    }
    // MARK: - Table view data source
}
extension FavoritesTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return recipes.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openRecipe(index: indexPath.section)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.setUpCell(recipe: self.recipes[indexPath.section])
        return cell
    }
    
}

