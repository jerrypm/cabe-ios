//
//  CBMainRouter.swift
//  CabeCare
//
//  Created by Jeri Purnama Maulid on 14/11/25.
//  Main module router - Creates custom tab bar with VIPER modules
//

import UIKit

class CBMainRouter {

    static func createModule() -> UIViewController {
        // Create TabBar module with VIPER architecture
        return CBTabBarRouter.createModule()
    }
}
