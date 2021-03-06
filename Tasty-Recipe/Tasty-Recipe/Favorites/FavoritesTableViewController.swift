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
    
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var errorLabel: CustomLabel!
    var recipes : [Recipe] = []
    let manager = Manager()
    var empty = "0"
    var remove = "0"
    
    override func viewDidLoad() {
        navigationController?.navigationBar.backgroundColor = .white

        super.viewDidLoad()
        
        // init recipe cell
        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
        self.clearsSelectionOnViewWillAppear = true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        manager.loadFavorites() { favoritesArray in
            self.recipes = favoritesArray
            if(self.recipes.count != 0){
                self.backgroundView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            self.tableView.reloadData()
        }
    }
    // refresh the table view
    @IBAction func refreshTableTapped(_ sender: Any) {
        empty = UserDefaults.standard.string(forKey: "isEmpty")!
        remove = UserDefaults.standard.string(forKey: "remove")!
        if(empty == "1" && remove == "1"){// if there is only one recipe anf it is removed
            self.backgroundView.frame = CGRect(x: 0, y: 0, width: 414, height: 696)
        }else{
            manager.loadFavorites() { favoritesArray in
                self.recipes = favoritesArray
                if(self.recipes.count != 0){
                    self.backgroundView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                }
                self.tableView.reloadData()
            }
        }
    }
    /*  func openRecipe(index: Int){
     UserDefaults.standard.set(self.recipes[index].name, forKey: "name")
     UserDefaults.standard.set(self.recipes[index].timeInMinutes, forKey: "timeInMinutes")
     UserDefaults.standard.set(self.recipes[index].serving, forKey: "serving")
     UserDefaults.standard.set(self.recipes[index].image, forKey: "image")
     UserDefaults.standard.set(self.recipes[index].category, forKey: "category")
     UserDefaults.standard.set(self.recipes[index].ingredients, forKey: "ingredients")
     UserDefaults.standard.set(self.recipes[index].instructions, forKey: "instructions")
     UserDefaults.standard.set(self.recipes[index].levelOfCooking, forKey: "levelOfCooking")
     
     }*/
    // MARK: - Table view data source
}
extension FavoritesTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        if(self.empty == "1" && self.remove == "1"){// if there is only one recipe anf it is removed
            recipes = []
        }
        return recipes.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*navigationController?.navigationBar.backgroundColor = .white
         self.performSegue(withIdentifier: "RecipeDetailSegueF", sender: self)
         openRecipe(index: indexPath.section)*/
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
