//
//  RecipeDetailViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/6/21.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    var recipe : Recipe?
    var name = ""
    var image = ""
    var ingredients = ""
    var instructions = ""
    var levelOfCooking = ""
    var category = ""
    var serving = 0
    var timeInMinutes = 0
    var recipeId = ""
    
    var headers = ["Description", "Ingredients", "Instructions"]
    @IBOutlet weak var tbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name = UserDefaults.standard.string(forKey: "name")!
        self.image = UserDefaults.standard.string(forKey: "image")!
        self.ingredients = UserDefaults.standard.string(forKey: "ingredients")!
        self.instructions = UserDefaults.standard.string(forKey: "instructions")!
        self.levelOfCooking = UserDefaults.standard.string(forKey: "levelOfCooking")!
        self.category = UserDefaults.standard.string(forKey: "category")!
        self.serving = UserDefaults.standard.integer(forKey: "serving")
        self.timeInMinutes = UserDefaults.standard.integer(forKey: "timeInMinutes")
        self.recipeId = UserDefaults.standard.string(forKey: "recipeId")!
        recipe = Recipe(name: self.name, id: recipeId, levelOfCooking: self.levelOfCooking, category: self.category, timeInMinutes: self.timeInMinutes, ingredients: self.ingredients, image: self.image, instructions: self.instructions, serving: self.serving)
        view.backgroundColor = .clear
        tbl.tableFooterView = UIView(frame: .zero)
        tbl.register(UINib.init(nibName: "RecipeDescriptionCell", bundle: nil), forCellReuseIdentifier: "RecipeDescriptionCell")
        tbl.register(UINib.init(nibName: "RecipeIngredientsCell", bundle: nil), forCellReuseIdentifier: "RecipeIngredientsCell")
        tbl.register(UINib.init(nibName: "RecipeInstructionsCell", bundle: nil), forCellReuseIdentifier: "RecipeInstructionsCell")
        tbl.dataSource = self
        tbl.delegate = self
    }
    
}
extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        365
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(headers[indexPath.section])
        let cell = UITableViewCell()
        if (headers[indexPath.section].contains("Description")){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeDescriptionCell") as! RecipeDescriptionCell
            cell.setUpCell(recipe!)
            return cell
        }
        if(headers[indexPath.section].contains("Ingredients")){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsCell") as! RecipeIngredientsCell
            cell.setUpCell(ingredients: (recipe?.ingredients!)!)
            return cell
        }
        if(headers[indexPath.section].contains("Instructions")){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeInstructionsCell") as! RecipeInstructionsCell
            cell.setUpCell(instructions: (recipe?.instructions!)!)
            return cell
        }
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tbl.frame.size.width, height: 50))
        view.backgroundColor = .systemOrange
        let titleLabel = UILabel(frame: view.frame)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        if(headers[section].contains("Description")){
            print("here")
            titleLabel.text = recipe?.name
        }else{
            titleLabel.text = headers[section]

        }
        view.addSubview(titleLabel)
        return view
    }
}
extension RecipeDetailViewController: UITableViewDelegate{
  
}
