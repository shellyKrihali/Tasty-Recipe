//
//  CustomNavigationController.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit

class CustomNavigationController: UINavigationController {

    //first loadng func
    override func viewDidLoad() {
        super.viewDidLoad()
        makeBarInvisable()

    }
    
    func makeBarInvisable(){
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
    

    
}
