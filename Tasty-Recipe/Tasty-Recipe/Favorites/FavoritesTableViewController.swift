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

    static var recipeCollectionRef: CollectionReference!
    var recipes : [Recipe] = []
  //  let items = ["pasta", "pasta", "pasta"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
        self.clearsSelectionOnViewWillAppear = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData() { recipesArray in
            self.recipes = recipesArray
            print("inside view did appear")
            print(self.recipes)
            print("after view did appear")
            self.tableView.reloadData()
                
        }
    }
    
    // MARK: - Table view data source
  
}
extension FavoritesTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        print("number of recipes")
        print(recipes.count)
        print("outside number of recipes")
        return recipes.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        print("FAVORITE inside cellforrowat")
        print(self.recipes[indexPath.section])
        print("FAVORITE outside cell for row at")
        cell.setUpCell(recipe: self.recipes[indexPath.section])
        return cell
    }
    
}
extension FavoritesTableViewController {
    func loadData(_ callback:@escaping (([Recipe]) -> Void)) {
        var recipesArray = [Recipe]()
        FavoritesTableViewController.recipeCollectionRef = Firestore.firestore().collection("recipes")
        FavoritesTableViewController.recipeCollectionRef.getDocuments { snapshot, error in
            if let err = error{
                print("error fetching docs\(err)")
            }
            else{
                guard let snap = snapshot else {return}
                for document in snap.documents{
                    
                    let name = document.get("name") as! String
                    let levelOfCooking = document.get("levelOfCooking") as! String
                    let category = document.get("category") as! String
                    let timeInMinutes = document.get("timeInMinutes") as! Int
                    let ingredients = document.get("ingredients") as! String
                    let image = document.get("image") as! String
                    let instructions = document.get("instructions") as! String
                    let serving = document.get("serving") as! Int
                    let recipe = Recipe(name: name, levelOfCooking: levelOfCooking, category: category, timeInMinutes: timeInMinutes, ingredients: ingredients, image: image, instructions: instructions, serving: serving)
                    recipesArray.append(recipe)
                    
                    if(recipesArray.count == snap.count){
                        RunLoop.main.perform{
                            callback(recipesArray)
                        }
                    }
                   
                }// after for docs loop
                
            }
        }
     
    }

    }
