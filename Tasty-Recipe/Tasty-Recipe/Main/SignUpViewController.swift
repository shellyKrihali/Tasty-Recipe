//
//  SignUpViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {

    
   
    @IBOutlet weak var nameTextField: CustomTextField!
    
    @IBOutlet weak var passwordTextField: CustomTextField!
    
    @IBOutlet weak var emailTextField: CustomTextField!
    
    //first loading func
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    //pops current view controller
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    //hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
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
