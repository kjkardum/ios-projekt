//
//  UINavigationControllerExtension.swift
//  GameDeals
//
//  Created by Five on 05.06.2022..
//

import Foundation
import UIKit

extension UINavigationController {
    static func createAppNavigationController() -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.backgroundColor = .navbarBackgroundColor
        navigationController.navigationBar.isTranslucent = true
        
        
        return navigationController
    }
}
