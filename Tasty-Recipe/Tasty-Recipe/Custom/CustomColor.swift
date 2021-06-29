//
//  CustomColor.swift
//  Tasty-Recipe
//
//  Created by user196689 on 6/29/21.
//

import Foundation

import UIKit
struct CustomColor {
    let orange: UIColor!
    
    init(withFrame: CGRect){
       
        orange = UIColor(red: 255/255, green: 140/255, blue: 43/255, alpha: 1)
    }
    func getOrangeColor() -> UIColor {
        return orange
    }
}
