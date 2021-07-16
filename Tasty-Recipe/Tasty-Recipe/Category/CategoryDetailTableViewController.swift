//
//  CategoryDetailTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/7/21.
//

import UIKit

class CategoryDetailTableViewController: UITableViewController {
    var recipes : [Recipe] = []
    let manager = Manager()

    
    @IBOutlet weak var backgroundView: UIView!
    
   
    

    @IBOutlet weak var categoryTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
        self.clearsSelectionOnViewWillAppear = true

        
    }
    override func viewDidAppear(_ animated: Bool) {
        let categoryChoice = UserDefaults.standard.string(forKey: "categoryChoice")!
        self.categoryTitle.title = categoryChoice
        manager.loadRecipeByCategory(category: categoryChoice ){
            recipesCategoryArray in
            
                self.recipes = recipesCategoryArray
            if(self.recipes.count == 0){
            
            }
            else{
                self.backgroundView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
            }
            
                self.tableView.reloadData()        }
    }

   
   /* @IBAction func backButtonTapped(_ sender: Any) {
        print("here")
            navigationController?.popViewController(animated: true)

    }
    */
    
 /*   @IBAction func backButtonTapped(_ sender: Any) {
        print("here")
            navigationController?.popViewController(animated: true)

    }*/
    
    
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
        
        navigationController?.navigationBar.backgroundColor = .white
        self.performSegue(withIdentifier: "RecipeDetailSegueC", sender: self)
        self.modalPresentationStyle = .fullScreen
        
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
