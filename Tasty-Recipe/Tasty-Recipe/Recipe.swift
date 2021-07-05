//
//  Recipe.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/4/21.
//

import Foundation
struct Recipe{
    var name: String?
    var levelOfCooking: String?
    var category: String?
    var timeInMinutes: Int?
    var ingredients: String?
    var image:String?
    var instructions:String?
    var serving:Int?
    
    init(name: String, levelOfCooking: String, category: String,timeInMinutes: Int, ingredients: String, image:String,instructions:String,serving:Int){
        self.name = name
        self.levelOfCooking = levelOfCooking
        self.category = category
        self.timeInMinutes = timeInMinutes
        self.ingredients = ingredients
        self.image = image
        self.instructions = instructions
        self.serving = serving
    }
    
}
    
