//
//  AppRouter.swift
//  GameDeals
//
//  Created by Five on 05.06.2022..
//

import Foundation
import UIKit


class AppRouter {
    var tabBarViewControler: TabBarViewController
    private let navigationController: UINavigationController
    
    init (tabBarViewController: TabBarViewController) {
        self.tabBarViewControler = tabBarViewController
        self.navigationController = UINavigationController.createAppNavigationController()
    }
    
    func setScreen(window: UIWindow?) {
        navigationController.pushViewController(tabBarViewControler, animated: true)
    
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
}
