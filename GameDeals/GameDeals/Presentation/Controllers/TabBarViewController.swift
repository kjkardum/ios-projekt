//
//  TabBarViewController.swift
//  GameDeals
//
//  Created by Five on 04.06.2022..
//

import Foundation
import UIKit
import SnapKit


class TabBarViewController: UITabBarController {
    private let dealsViewController: DealsViewController
    private let searchViewController: SearchViewController
    
    init(dealsViewController: DealsViewController, searchViewController: SearchViewController) {
        self.dealsViewController = dealsViewController
        self.searchViewController = searchViewController
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.backgroundColor = .clear
        tabBar.tintColor = UIColor.toolbarIconColor
        
        let homeNavigationViewController = UINavigationController(rootViewController: dealsViewController)
                
        let tabOne = UITabBarItem(
            title: nil, image: UIImage(systemSymbol: .house)
                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal),
            
            selectedImage: UIImage(systemSymbol: .houseFill)
                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal))
        
        
        
        homeNavigationViewController.tabBarItem = tabOne
        
        let searchNavigationViewController = UINavigationController(rootViewController: searchViewController)
        let tabTwo = UITabBarItem(
            title: nil, image: UIImage(systemSymbol: .magnifyingglass)
                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal),
            
            selectedImage: UIImage(systemSymbol: .sparkleMagnifyingglass)
                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal))
        
        
        searchNavigationViewController.tabBarItem = tabTwo
        
        self.viewControllers = [homeNavigationViewController, searchNavigationViewController]
    }
}


extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0 {
            dealsViewController.tabBarClickedHome()
        }
        
        return true
    }
}
