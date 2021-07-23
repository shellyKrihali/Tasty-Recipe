//
//  NewRecipeTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/4/21.
//

import UIKit
import Firebase
class NewRecipeTableViewController: UITableViewController,UITextFieldDelegate {

    let db = Firebase.Firestore.firestore()
    let storage = Firebase.Storage.storage().reference()
    
    @IBOutlet weak var nameTextField: CustomTextField!
    
    @IBOutlet weak var ingredientsTextField: CustomTextField!
    
    @IBOutlet weak var servingTextField: CustomTextField!
    
    @IBOutlet weak var instructionsTextField: CustomTextField!
    
    @IBOutlet weak var timeInMinTextField: CustomTextField!
    
    @IBOutlet weak var newImageSelect: UIImageView!
    
    @IBOutlet weak var uploadImageButton: CustomButton!
    
    @IBOutlet weak var createNewRecipeButton: CustomButton!
   
    @IBOutlet weak var segmentedCategories: UISegmentedControl!
    
    @IBOutlet weak var segmentedLevelOfCooking: UISegmentedControl!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadImageButton.makeCustomWhiteButton()
        errorLabel.alpha = 0
        self.segmentedLevelOfCooking.selectedSegmentIndex = 0
        self.segmentedCategories.selectedSegmentIndex = 0
        self.nameTextField.delegate = self
        self.ingredientsTextField.delegate = self
        self.servingTextField.delegate = self
        self.instructionsTextField.delegate = self
        self.timeInMinTextField.delegate = self
    }
    
    
    @IBAction func createNewRecipeTapped(_ sender: Any) {
        let error = fieldsAreFilled()
        if(error != nil){
            errorLabel.text = error
            errorLabel.alpha = 1
        }else{
            let id = UUID().uuidString
            let name = nameTextField.text
            let categories = Constants.categories
            let category = categories[self.segmentedCategories.selectedSegmentIndex]
            let ingredients = ingredientsTextField.text
            let instructions = instructionsTextField.text
            let levels = ["EASY" ,"MIDDLE", "HARD"]
            let levelOfCooking = levels[self.segmentedLevelOfCooking.selectedSegmentIndex]
            
            
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
                            "category": category,
                            "ingredients": ingredients!,
                            "instructions": instructions!,
                            "levelOfCooking": levelOfCooking,
                            "timeInMinutes": timeInMinutes,
                            "serving": servingFor,
                            "image": imageURL
                        ]
                            
                        )
                        self.nameTextField.text = ""
                        self.segmentedCategories.selectedSegmentIndex = 0
                        self.ingredientsTextField.text = ""
                        self.instructionsTextField.text = ""
                        self.segmentedLevelOfCooking.selectedSegmentIndex = 0
                        self.timeInMinTextField.text = ""
                        self.servingTextField.text = ""
                        self.newImageSelect.image = UIImage(systemName: "plus.rectangle.on.folder")
                        
                    }
                    self.errorLabel.alpha = 1
                   self.errorLabel.text = "Recipe Uploaded Sucessfully"
                }else{
                }
           
            
        }
        }
        
    }
    
    @IBAction func uploadImageTapped(_ sender: Any) {
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

    @IBAction func segmentedSectionTapped(_ sender: Any) {
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.switchBasedNextTextField(textField)
        return true
        
    }
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameTextField:
            self.ingredientsTextField.becomeFirstResponder()
        case self.ingredientsTextField:
            self.instructionsTextField.becomeFirstResponder()
        case self.instructionsTextField:
            self.servingTextField.becomeFirstResponder()
        case self.servingTextField:
            self.timeInMinTextField.becomeFirstResponder()
        default:
            self.timeInMinTextField.resignFirstResponder()
        }
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
    


