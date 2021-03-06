//
//  Manager.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/7/21.
//

import Foundation
import FirebaseFirestore
import UIKit
class Manager{
    var recipeCollectionRef: CollectionReference!
    
    // add recipe to favorites fiels in user collection
    func loadRecipeToFavorites(recipe: Recipe){
        let id = UserDefaults.standard.string(forKey: "id")!
        Firestore.firestore().collection("users").document(id).updateData(["favorites": FieldValue.arrayUnion([recipe.id!])])
    }
    // check if the recipe in user favorites array
    func loadFavoriteStatus(recipe: Recipe,_ callback:@escaping ((Bool) -> Void)){
        var flag: Bool = false
        let id = UserDefaults.standard.string(forKey: "id")!
        Firestore.firestore().collection("users").document(id).getDocument(){
            snapshot, error in
            let array : [String] = snapshot!.get("favorites") as! [String]
            if(array.contains(recipe.id!)){
                RunLoop.main.perform{
                    flag = true
                    callback(flag)
                }
            }else{
                RunLoop.main.perform{
                    flag = false
                    callback(flag)
                }
            }
        }
    }
    // load favorites recipes from the user collection
    func loadFavorites(_ callback:@escaping (([Recipe]) -> Void)){
        let id = UserDefaults.standard.string(forKey: "id")!
        var favoritesArray = [Recipe]()
        favoritesArray = []
        Firestore.firestore().collection("users").document(id).getDocument(){
            snapshot, error in
            let array : [String] = snapshot!.get("favorites") as! [String]
            for item in array{
                 Firestore.firestore().collection("recipes").document(item).getDocument{document,error in
                    if(document == nil){
                    }else{
                        let name = document?.get("name") as! String
                        let levelOfCooking = document?.get("levelOfCooking") as! String
                        let category = document?.get("category") as! String
                        let timeInMinutes = document?.get("timeInMinutes") as! Int
                        let ingredients = document?.get("ingredients") as! String
                        let image = document?.get("image") as! String
                        let instructions = document?.get("instructions") as! String
                        let serving = document?.get("serving") as! Int
                        let recipeId = document?.get("id") as! String
                        let recipe = Recipe(name: name,id: recipeId ,levelOfCooking: levelOfCooking, category: category, timeInMinutes: timeInMinutes, ingredients: ingredients, image: image, instructions: instructions, serving: serving)
                        favoritesArray.append(recipe)
                    }
                    if(favoritesArray.count == 1){
                        UserDefaults.standard.set(1, forKey: "isEmpty")
                    }
                    else{
                        UserDefaults.standard.set(0, forKey: "isEmpty")
                    }
                    RunLoop.main.perform{
                        callback(favoritesArray)
                    }
                }
            }
        }
    }
    // delete recipe id from favorites field in user collection
    func removeRecipeFromFavorites(recipe: Recipe){
        let id = UserDefaults.standard.string(forKey: "id")!
        Firestore.firestore().collection("users").document(id).updateData(["favorites": FieldValue.arrayRemove([recipe.id!])]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    // load recipe by given category
    func loadRecipeByCategory(category: String,_ callback:@escaping (([Recipe]) -> Void)) {
        var recipesCategoryArray = [Recipe]()
        recipeCollectionRef = Firestore.firestore().collection("recipes")
        recipeCollectionRef.whereField("category", isEqualTo: category ).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let recipe = self.loadRecipeFromDocument(document: document)
                    recipesCategoryArray.append(recipe)
                    if(recipesCategoryArray.count == querySnapshot!.count){
                        RunLoop.main.perform{
                            callback(recipesCategoryArray)
                        }
                    }
                }
            }
        }
    }
    // load each recipe information
    func loadRecipeFromDocument(document: QueryDocumentSnapshot) -> Recipe{
        let name = document.get("name") as! String
        let levelOfCooking = document.get("levelOfCooking") as! String
        let category = document.get("category") as! String
        let timeInMinutes = document.get("timeInMinutes") as! Int
        let ingredients = document.get("ingredients") as! String
        let image = document.get("image") as! String
        let instructions = document.get("instructions") as! String
        let serving = document.get("serving") as! Int
        let recipeId = document.get("id") as! String
        let recipe = Recipe(name: name,id: recipeId ,levelOfCooking: levelOfCooking, category: category, timeInMinutes: timeInMinutes, ingredients: ingredients, image: image, instructions: instructions, serving: serving)
        return recipe
    }
    // load recipes from firebase from "recipes" collection
    func loadData(_ callback:@escaping (([Recipe]) -> Void)) {
        var recipesArray = [Recipe]()
        recipeCollectionRef = Firestore.firestore().collection("recipes")
        recipeCollectionRef.getDocuments { snapshot, error in
            if let err = error{
                print("error fetching docs\(err)")
            }
            else{
                guard let snap = snapshot else {return}
                for document in snapshot!.documents{
                    let recipe = self.loadRecipeFromDocument(document: document)
                    recipesArray.append(recipe)
                    if(recipesArray.count == snap.count){
                        RunLoop.main.perform{
                            callback(recipesArray)
                        }
                    }
                }
            }
        }
    }
    
}
