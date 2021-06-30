//
//  SignUpViewController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit

class SignUpViewController: UIViewController {

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
