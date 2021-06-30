//
//  CustomTextField.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/30/21.
//

import UIKit

class CustomTextField: UITextField {
    //first loading func
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetUp()
    }
    //first required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetUp()
    }
    func defaultSetUp() {
        
        //textfields
        layer.borderColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1).cgColor
        layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)
        layer.borderWidth = 1
        
    }

}
