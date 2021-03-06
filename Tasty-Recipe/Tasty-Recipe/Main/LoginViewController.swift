//
//  LoginViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class LoginViewController: UIViewController , UITextFieldDelegate{
    
    //UI view properties
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var paasswordTextField: UITextField!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginButton: CustomButton!
    
    @IBOutlet weak var errorLabel: CustomLabel!
    
    let manager = Manager()
    //first load func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProperties()
    }
    
    func setUpProperties(){
        navigationController?.navigationBar.layer.frame.origin.y = 22
        // hide error label
        errorLabel.alpha = 0
        paasswordTextField.isSecureTextEntry = true
    }
    
    //pops current view controller
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // login button tapped
    @IBAction func LoginButtonTapped(_ sender: Any) {
        // validate text fields
        let error = validateFields()
        if (error != nil){
            showError(error!)
        }
        //create clean version of the text fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = paasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //login to the firestore
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if (error != nil){
                self.showError(error!.localizedDescription)
            }else {
                self.transitionToTabBar()
                UserDefaults.standard.setValue(result!.user.uid, forKey: "id")
            }
        }
    }
    // go to main tabbar
    func transitionToTabBar(){
        let tapbarController = storyboard?.instantiateViewController(identifier: Constants.Stroyboard.tapbar)
        view.window?.rootViewController = tapbarController
        
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    //validate te fields and check if the data is correct-> returns nil, else, returns nil.
    func validateFields() -> String?{
        if( emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" || paasswordTextField.text?.trimmingCharacters(in: .whitespaces) == ""){
            return "Please fill in all fields"
        }
        return nil
    }}

// textfield slides up
extension LoginViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        topConstraint.constant = CGFloat(40)
        navigationController?.navigationBar.isHidden = true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        topConstraint.constant = CGFloat(101)
    }
    
    // handle enter tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationController?.navigationBar.isHidden = false
        switch textField {
        case self.emailTextField:
            self.paasswordTextField.becomeFirstResponder()
        default:
            self.paasswordTextField.resignFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
}

