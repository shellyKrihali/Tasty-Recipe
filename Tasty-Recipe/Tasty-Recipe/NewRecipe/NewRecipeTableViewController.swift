//
//  NewRecipeTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/4/21.
//

import UIKit
import Firebase
class NewRecipeTableViewController: UITableViewController {

    let db = Firebase.Firestore.firestore()
    let storage = Firebase.Storage.storage().reference()
    
    @IBOutlet weak var nameTextField: CustomTextField!
    
    @IBOutlet weak var categoryTextField: CustomTextField!
    
    @IBOutlet weak var ingredientsTextField: CustomTextField!
    
    @IBOutlet weak var servingTextField: CustomTextField!
    
    @IBOutlet weak var levelOfCookingTextField: CustomTextField!
    
    @IBOutlet weak var instructionsTextField: CustomTextField!
    
    @IBOutlet weak var timeInMinTextField: CustomTextField!
    
    @IBOutlet weak var newImageSelect: UIImageView!
    
    @IBOutlet weak var uploadImageButton: CustomButton!
    
    
    @IBOutlet weak var createNewRecipeButton: CustomButton!
    
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImageButton.makeCustomWhiteButton()
        errorLabel.alpha = 0
       
    }
    
    @IBAction func createNewRecipeTapped(_ sender: Any) {
        let error = fieldsAreFilled()
        if(error != nil){
            errorLabel.text = error
            errorLabel.alpha = 1
        }else{
            let id = UUID().uuidString

            let name = nameTextField.text
            let category = categoryTextField.text
            let ingredients = ingredientsTextField.text
            let instructions = instructionsTextField.text
            let levelOfCooking = levelOfCookingTextField.text
            let timeInMinutes = (timeInMinTextField.text! as NSString).integerValue
            let servingFor = (servingTextField.text! as NSString).integerValue
            
            guard let image = newImageSelect.image?.pngData() else{ return}
            let ref = storage.child("recipes/\(id).png")
            ref.putData(image, metadata: nil){_, error in
                if(error == nil){
                    self.convertImageStorageToImageURL(id) {imageURL in
                        self.errorLabel.alpha = 0
                        self.db.collection("recipes").document(id).setData(
                        [
                            "id" : id,
                            "name": name!,
                            "category": category!,
                            "ingredients": ingredients!,
                            "instructions": instructions!,
                            "levelOfCooking": levelOfCooking!,
                            "timeInMinutes": timeInMinutes,
                            "serving": servingFor,
                            "image": imageURL
                        ]
                            
                        )
                        self.nameTextField.text = ""
                        self.categoryTextField.text = ""
                        self.ingredientsTextField.text = ""
                        self.instructionsTextField.text = ""
                        self.levelOfCookingTextField.text = ""
                        self.timeInMinTextField.text = ""
                        self.servingTextField.text = ""
                        self.newImageSelect.image = UIImage(systemName: "plus.rectangle.on.folder")
                        
                    }
                }
           
            
        }
        }}
    
    @IBAction func uploadImageTapped(_ sender: Any) {
        print("inside upload image Tapped")
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
    func fieldsAreFilled() -> String? {
        if(nameTextField.text!.isEmpty){
            return "Please enter recipe name"
        }
        if(categoryTextField.text!.isEmpty){
            return "Please enter recipe category"
        }
        if(levelOfCookingTextField.text!.isEmpty){
            return "Please enter recipe level of cooking"
        }
        if(ingredientsTextField.text!.isEmpty){
            return "Please enter recipe ingredients"
        }
        if(instructionsTextField.text!.isEmpty){
            return "Please enter recipe instructions"
        }
        if(servingTextField.text!.isEmpty){
            return "Please enter recipe serving"
        }
        
        if(timeInMinTextField.text!.isEmpty){
            return "Please enter recipe time in minutes"
        }
        
        return nil
        
    }
    func convertImageStorageToImageURL(_ imageId: String, _ callback:@escaping ((String) -> Void)) {
            var urlString = ""
            urlString = ""
            storage.child("recipes/\(imageId).png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                urlString = url.absoluteString
                callback(urlString)
            }
        }
        
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   

}
extension NewRecipeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         if let imageR = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
             newImageSelect.image = imageR
         }
         
         picker.dismiss(animated: true, completion: nil)
     }
     
     func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         picker.dismiss(animated: true, completion: nil)
     }
}

