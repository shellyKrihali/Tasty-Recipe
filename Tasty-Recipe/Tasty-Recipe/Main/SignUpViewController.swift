//
//  SignUpViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
class SignUpViewController: UIViewController,UITextFieldDelegate {

    
   
    @IBOutlet weak var nameTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    
    @IBOutlet weak var signUpButton: CustomButton!
    
    
    @IBOutlet weak var errorLabel: CustomLabel!
    
    //first loading func
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0

    }
    //pops current view controller
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //validate te fields and check if the data is correct-> returns nil, else, returns nil.
    func validateFields() -> String?{
        if(nameTextField.text?.trimmingCharacters(in: .whitespaces) == "" || emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespaces) == ""){
            return "Please fill in all fields"
        }
        return nil
        
    }
    @IBAction func signUpTapped(_ sender: Any) {
        
        //validate the fields
        let error = validateFields()
        
        if (error != nil){
           showError(error!)
            
        }else {
            
            //validate the fields without white spaces
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create the user
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                //check for errors
                if (err != nil) {
                    self.showError("Error Creating User")
                    
                }
                else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["name":name,"uid": result!.user.uid]) { error in
                        
                        if (error != nil){
                            self.showError("Error saving user data")
                            
                        }
                    }
                    self.transitionToTabBar()
                }
            }
            
            
        }
        
        
    }
    func transitionToTabBar(){
        let tapbarController = storyboard?.instantiateViewController(identifier: Constants.Stroyboard.tapbar)
        view.window?.rootViewController = tapbarController
        
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
}
extension SignUpViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        navigationController?.navigationBar.isHidden = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.navigationBar.isHidden = false
        textField.resignFirstResponder()
        return true
    }
    
}
