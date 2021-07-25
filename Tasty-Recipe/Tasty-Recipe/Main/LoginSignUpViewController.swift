//
//  LoginSignUpViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/29/21.
//

import UIKit

class LoginSignUpViewController: UIViewController {

    //UI view properties
    @IBOutlet weak var dontHaveAccountLabel: CustomLabel!
    
    @IBOutlet weak var loginButton: CustomButton!
    
    @IBOutlet weak var signupButton: CustomButton!
    
    @IBOutlet weak var TastyLabel: CustomLabel!
    
    //first loading func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProperties()
    }

    func setUpProperties(){
        signupButton.makeCustomWhiteButton()
        TastyLabel.setSpacing(space: 1.75)
    }
    //hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
