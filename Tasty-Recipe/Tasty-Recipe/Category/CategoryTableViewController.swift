//
//  CategoryTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import Firebase
class CategoryTableViewController: UITableViewController {

    static var recipeCollectionRef: CollectionReference!

//    let items = ["APPETIZER","BREAKFAST & LUNCH", "DESSERT", "BEVREGES", "MAIN DISH", "PASTA","SALAD", "SOUP"]
    var categories: [String] = []
    var items: [[Recipe]] = [[]]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories() {
            categoriesArray in
            self.categories = categoriesArray
            print("inside Category view did appear")
            print(self.categories)
            print("putside Category view did appear")
            //self.tableView.reloadData()
            self.loadData(categoriesR: self.categories, callback: {
                recipesArray in
                self.items = recipesArray
//                print("inside load recipes")
//                print(self.items)
//                print("after load recipes")
                
                self.tableView.reloadData()
            })

        }

        let recipeCell = UINib.init(nibName: "RecipeCell", bundle: nil)
        self.tableView.register(recipeCell, forCellReuseIdentifier: "RecipeCell")
        let headerView = UINib(nibName: "HeaderView", bundle: nil)
        self.tableView.register(headerView, forHeaderFooterViewReuseIdentifier: "HeaderView")
        self.clearsSelectionOnViewWillAppear = true
    }
    override func viewDidAppear(_ animated: Bool) {

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return categories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return items[section].count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        cell.categoryLabel.text = categories[indexPath.row]*/
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath) as! RecipeCell
        print(" WOOOOOW")
        print(items[indexPath.section][indexPath.row])
        print("AFTER WWOOOWWW")
        cell.setUpCell(recipe: self.items[indexPath.section][indexPath.row])
        //items[indexPath]
//stoppedHEREEEEE
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //instead 64
        return 260
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
        headerView.headerLabel.text = categories[section]
        return headerView
    }

}
extension CategoryTableViewController{
    func loadData(categoriesR: [String] ,callback:@escaping (([[Recipe]]) -> Void)) {
        print("LOAD DATA")
        var recipesArray = [[Recipe]](repeating: [Recipe(name: "", levelOfCooking: "", category: "", timeInMinutes: 0, ingredients: "", image: "", instructions: "", serving: 0)], count: categoriesR.count)
        var categoriesIsFirst = [String](repeating: "yes", count: categories.count)
        CategoryTableViewController.recipeCollectionRef = Firestore.firestore().collection("recipes")
        CategoryTableViewController.recipeCollectionRef.getDocuments { snapshot, error in
            if let err = error{
                print("error fetching docs\(err)")
            }
            else{
                guard let snap = snapshot else {return}
                
                for document in snapshot!.documents{
                   print("INSIDE DOCS")
                    
                    let name = document.get("name") as! String
                    let levelOfCooking = document.get("levelOfCooking") as! String
                    let categori = document.get("category") as! String
                    
                    let timeInMinutes = document.get("timeInMinutes") as! Int
                    let ingredients = document.get("ingredients") as! String
                    let image = document.get("image") as! String
                    let instructions = document.get("instructions") as! String
                    let serving = document.get("serving") as! Int
                    let recipe = Recipe(name: name, levelOfCooking: levelOfCooking, category: categori, timeInMinutes: timeInMinutes, ingredients: ingredients, image: image, instructions: instructions, serving: serving)
                    print(categoriesR)
                    var i = 0
                    for category in categoriesR{
//                        print(categoriesR)
//                        print(categori)
//                        print(category)
//                        print(i)
                        if (categori == category){
                            print("inside if")
                            if(categoriesIsFirst[i] == "yes"){
                                recipesArray[i].remove(at: 0)
                                categoriesIsFirst[i] = "no"
                            }
                            
                            recipesArray[i].append(recipe)
                        }
                        
                        i += 1
                    }
                   
                    //print(recipesArray)

                   
                    if(recipesArray.joined().count == snap.count){
                        RunLoop.main.perform{
                            callback(recipesArray)
                        }
                    }
                }  // after for docs loop
            }
        }
        print("FavoriteRecipesss=====================")
            }
    func loadCategories(_ callback:@escaping (([String]) -> Void)){
        var categoriesArray = [String]()
        var i = 0
        CategoryTableViewController.recipeCollectionRef = Firestore.firestore().collection("recipes")
        CategoryTableViewController.recipeCollectionRef.getDocuments { snapshot, error in
            if let err = error{
                print("error fetching docs\(err)")
            }else{
                guard let snap = snapshot else {return}
                for document in snapshot!.documents{
                    
                    
                    let category = document.get("category") as! String
                    if(!categoriesArray.contains(category)){
                        categoriesArray.append(category)
                    }
                    i += 1
                    if(i == snap.count){
                        RunLoop.main.perform{
                            callback(categoriesArray)
                        }
                    }
                }  // after for docs loop
                
            }
            }
        }
}
