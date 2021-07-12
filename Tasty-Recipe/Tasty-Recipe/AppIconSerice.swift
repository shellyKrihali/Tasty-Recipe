//
//  AppIconSerice.swift
//  Tasty-Recipe
//
//  Created by user196689 on 7/12/21.
//

import Foundation
import UIKit
class AppIconService{
    let application = UIApplication.shared
    /*enum AppIcon: String{
        case AppIcons
    }*/
    func changeAppIcon(){
        application.setAlternateIconName("AppIcons")
    }
}
