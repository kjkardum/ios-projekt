//
//  AppRouter.swift
//  GameDeals
//
//  Created by Five on 05.06.2022..
//

import Foundation
import UIKit


class AppRouter {
    private var tabBarViewControler: TabBarViewController
    private let navigationController: UINavigationController
    private var detailsViewController: DetailsViewController
    private let dealsViewConntroller: DealsViewController
    private let searchViewController: SearchViewController
    
    
    init (tabBarViewController: TabBarViewController,
          detailsViewController: DetailsViewController,
          dealsViewConntroller: DealsViewController,
          searchViewController: SearchViewController) {
        
        self.tabBarViewControler = tabBarViewController
        self.detailsViewController = detailsViewController
        self.dealsViewConntroller = dealsViewConntroller
        self.searchViewController = searchViewController
        self.navigationController = UINavigationController.createAppNavigationController()
        
        self.dealsViewConntroller.appRouter = self
        self.searchViewController.appRouter = self
        self.detailsViewController.appRouter = self
    }
    
    func setScreen(window: UIWindow?) {
        navigationController.pushViewController(tabBarViewControler, animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func popBack() {
        navigationController.popViewController(animated: true)
    }
    
    func showDeal(_ dealId: String) {
        detailsViewController.loadData(dealId: dealId)
        navigationController.pushViewController(detailsViewController, animated: true)
    }
}
