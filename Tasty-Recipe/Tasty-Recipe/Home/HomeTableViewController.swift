//
//  HomeTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class HomeTableViewController: UITableViewController {

    
    @IBOutlet weak var LogOutButton: UIBarButtonItem!
    
    @IBOutlet weak var SearchButton: UIBarButtonItem!
    
    var recipes : [Recipe] = []
    let manager = Manager()
    

    static var recipeCollectionRef: CollectionReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /* let searchBar = UISearchBar()
        searchBar.sizeToFit()

        searchBar.placeholder = "Search"

            navigationItem.titleView = searchBar*/
        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
        
      
        self.clearsSelectionOnViewWillAppear = true
    }
    override func viewDidAppear(_ animated: Bool) {
        manager.loadData() { recipesArray in
            self.recipes = recipesArray
            self.tableView.reloadData()
                
        }
        
       
    }
    
    @IBAction func LogOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "id")
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginSignUpVC = storyboard.instantiateViewController(withIdentifier: "loginSignUpViewController") as! LoginSignUpViewController
        self.present(loginSignUpVC, animated: true, completion: nil)
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            }
            catch
                let signOutError as NSError {
                print("Error signing out: %@", signOutError)
                }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return recipes.count
    }
    func openRecipe(index: Int){
        UserDefaults.standard.set(self.recipes[index].name, forKey: "name")
        UserDefaults.standard.set(self.recipes[index].id, forKey: "recipeId")

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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 260
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openRecipe(index: indexPath.section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        
      
        cell.setUpCell(recipe: self.recipes[indexPath.section])
        return cell
    }
}
