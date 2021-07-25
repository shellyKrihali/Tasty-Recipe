//
//  HomeTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import Firebase
import FirebaseFirestore
class HomeTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet var table: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var LogOutButton: UIBarButtonItem!
    
    @IBOutlet weak var SearchButton: UIBarButtonItem!
    
    @IBOutlet weak var errorLabel: CustomLabel!
    
    @IBOutlet weak var backgroundView: UIView!
    var recipes : [Recipe] = []
    var currentRecipes: [Recipe] = []
    let manager = Manager()
    
    static var recipeCollectionRef: CollectionReference!
    var names : [String] = []
    override func viewDidLoad() {
        navigationController?.navigationBar.backgroundColor = .white

        super.viewDidLoad()
        
        // init recipe cell
        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
        
        //set up search bar
        setUpSearchBar()
        
        alterLayout()
        self.clearsSelectionOnViewWillAppear = true
    }
    override func viewDidAppear(_ animated: Bool) {
        manager.loadData() { recipesArray in
            self.recipes = recipesArray
            if(self.recipes.count != 0){
                self.backgroundView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            self.currentRecipes = self.recipes
            self.tableView.reloadData()
            for recipe in self.recipes{
                self.names.append(recipe.name!)
            }
        }
    }
    private func alterLayout(){
        table.tableHeaderView = UIView()
        table.estimatedSectionHeaderHeight = 50
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search By Name"
    }
    private func setUpSearchBar(){
        searchBar.delegate = self
    }
    // search for recipes and show them inthe table view
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            currentRecipes = recipes
            table.reloadData()
            return
            
        }
        currentRecipes = recipes.filter({
            recipe -> Bool in
            return recipe.name!.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    // log out from user
    @IBAction func LogOutButtonTapped(_ sender: Any) {
        UserDefaults.standard.set("", forKey: "id")
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginSignUpNC = storyboard.instantiateViewController(withIdentifier: "MainNavController") as! UINavigationController
        
        loginSignUpNC.modalPresentationStyle = .fullScreen
        self.present(loginSignUpNC, animated: true, completion: nil)
        
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
        return currentRecipes.count
    }
    func openRecipe(index: Int){
        UserDefaults.standard.set(self.currentRecipes[index].name, forKey: "name")
        UserDefaults.standard.set(self.currentRecipes[index].id, forKey: "recipeId")
        UserDefaults.standard.set(self.currentRecipes[index].timeInMinutes, forKey: "timeInMinutes")
        UserDefaults.standard.set(self.currentRecipes[index].serving, forKey: "serving")
        UserDefaults.standard.set(self.currentRecipes[index].image, forKey: "image")
        UserDefaults.standard.set(self.currentRecipes[index].category, forKey: "category")
        UserDefaults.standard.set(self.currentRecipes[index].ingredients, forKey: "ingredients")
        UserDefaults.standard.set(self.currentRecipes[index].instructions, forKey: "instructions")
        UserDefaults.standard.set(self.currentRecipes[index].levelOfCooking, forKey: "levelOfCooking")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
    // go to recipe detail view controller, with user defaults including recipe information
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.navigationBar.backgroundColor = .white
        self.performSegue(withIdentifier: "RecipeDetailH", sender: self)
        openRecipe(index: indexPath.section)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show recipe cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        cell.setUpCell(recipe: self.currentRecipes[indexPath.section])
        return cell
    }
    // once tpped enter, hide keyboard
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
