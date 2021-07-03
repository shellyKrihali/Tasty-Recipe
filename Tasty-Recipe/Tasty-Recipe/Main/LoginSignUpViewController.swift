//
//  LoginSignUpViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/29/21.
//

import UIKit
import FirebaseDatabase
class LoginSignUpViewController: UIViewController {

    //UI view properties
    @IBOutlet weak var dontHaveAccountLabel: CustomLabel!
    @IBOutlet weak var loginButton: CustomButton!
    @IBOutlet weak var signupButton: CustomButton!
    
    @IBOutlet weak var TastyLabel: CustomLabel!
    
    private var database = Database.database().reference()
    
    //first loading func
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProperties()
       /* let button = UIButton(frame: CGRect(x: 20, y: 200, width: view.frame.size.width-40, height: 50))
        button.setTitle("Add entry ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        view.addSubview(button)
        button.addTarget(self, action: #selector(addNewEntry), for:.touchUpInside)*/
        // Do any additional setup after loading the view.
    }
 /*   @objc private func addNewEntry() {
        let object: [String: Any] = ["name": "Shelly" as NSObject,
                                        "is Pretty": "yesss"]
        
        database.child("something").setValue(object)
    }*/
    func setUpProperties(){
        
        signupButton.makeCustomWhiteButton()
        TastyLabel.setSpacing(space: 1.75)
    }
    //hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    

}
