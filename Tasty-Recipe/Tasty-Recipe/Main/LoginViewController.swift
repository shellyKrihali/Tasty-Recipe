//
//  LoginViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit

class LoginViewController: UIViewController , UITextFieldDelegate{

    //UI view properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var paasswordTextField: UITextField!
    
    
    //first load func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProperties()
        // Do any additional setup after loading the view.
    }
    
    func setUpProperties(){
        navigationController?.navigationBar.layer.frame.origin.y = 22

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
    //textfield slides up
    extension LoginViewController {
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

