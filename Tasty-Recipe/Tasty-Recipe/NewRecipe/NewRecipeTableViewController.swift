//
//  NewRecipeTableViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/4/21.
//

import UIKit
import Firebase
class NewRecipeTableViewController: UITableViewController,UITextFieldDelegate, UITextViewDelegate {
    
    let db = Firebase.Firestore.firestore()
    let storage = Firebase.Storage.storage().reference()
    
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var nameTextField: CustomTextField!
    

    
    @IBOutlet weak var servingTextField: CustomTextField!
    
   
    @IBOutlet weak var instructionsTextView: UITextView!
    
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
        
        //init default segmentes options
        self.segmentedLevelOfCooking.selectedSegmentIndex = 0
        self.segmentedCategories.selectedSegmentIndex = 0
        
        self.nameTextField.delegate = self
        self.ingredientsTextView.delegate = self
        self.servingTextField.delegate = self
        self.instructionsTextView.delegate = self
        self.timeInMinTextField.delegate = self
        
        defaultSetUpTextView(textview: instructionsTextView)
        defaultSetUpTextView(textview: ingredientsTextView)
    }
    
    // creates new recipe document after create tapped
    @IBAction func createNewRecipeTapped(_ sender: Any) {
        let error = fieldsAreFilled()
        if(error != nil){
            errorLabel.text = error
            errorLabel.alpha = 1
        }else{
            // creates new recipe document
            let id = UUID().uuidString
            let name = nameTextField.text
            let categories = Constants.categories
            let category = categories[self.segmentedCategories.selectedSegmentIndex]
            let ingredients = ingredientsTextView.text
            let instructions = instructionsTextView.text
            let levels = ["EASY" ,"MIDDLE", "HARD"]
            let levelOfCooking = levels[self.segmentedLevelOfCooking.selectedSegmentIndex]
            
            
            let timeInMinutes = (timeInMinTextField.text! as NSString).integerValue
            let servingFor = (servingTextField.text! as NSString).integerValue
            
            
            // add convert image to url and saves in the recipe image field
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
                        self.ingredientsTextView.text = ""
                        self.instructionsTextView.text = ""
                        self.segmentedLevelOfCooking.selectedSegmentIndex = 0
                        self.timeInMinTextField.text = ""
                        self.servingTextField.text = ""
                        self.newImageSelect.image = UIImage(systemName: "plus.rectangle.on.folder")
                    }
                    self.errorLabel.alpha = 1
                    self.errorLabel.text = "Recipe Uploaded Sucessfully"
                }else{
                    print("error")
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
    
    // check if all fields are filled
    func fieldsAreFilled() -> String? {
        if(nameTextField.text!.isEmpty){
            return "Please enter recipe name"
        }
        
        if(ingredientsTextView.text!.isEmpty){
            return "Please enter recipe ingredients"
        }
        if(instructionsTextView.text!.isEmpty){
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
        // add image to forebase storage
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
        
        // orginizing the next text field by clicking enter
        switch textField {
        case self.nameTextField:
            self.ingredientsTextView.becomeFirstResponder()
        case self.ingredientsTextView:
            self.instructionsTextView.becomeFirstResponder()
        case self.instructionsTextView:
            self.servingTextField.becomeFirstResponder()
        case self.servingTextField:
            self.timeInMinTextField.becomeFirstResponder()
        default:
            self.timeInMinTextField.resignFirstResponder()
        }
    }
    func defaultSetUpTextView(textview: UITextView) {
        
        //textfields
        textview.layer.borderColor = UIColor(red: 169/255, green: 169/255, blue: 169/255, alpha: 1).cgColor
        textview.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        textview.layer.borderWidth = 1
        
        textview.layer.masksToBounds = true
        
    }
    
}
extension NewRecipeTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // after picking the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imageR = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            newImageSelect.image = imageR
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    // on cancel clicked
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
