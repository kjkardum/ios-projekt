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
        setTabs()
    }
    
    func setTabs() {
            tabBar.backgroundColor = .clear
            tabBar.tintColor = UIColor.toolbarIconColor
            
            dealsViewController.tabBarItem = UITabBarItem(title: nil,
                                                          image: UIImage(systemSymbol: .house)
                                                                .withTintColor(UIColor.toolbarIconColor,renderingMode: .alwaysOriginal),
                                                          selectedImage: UIImage(systemSymbol: .houseFill)
                                                                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal))
            
            
            searchViewController.tabBarItem = UITabBarItem(title: nil,
                                                           image: UIImage(systemSymbol: .magnifyingglassCircle)
                                                                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal),
                                                           selectedImage: UIImage(systemSymbol: .magnifyingglassCircleFill)
                                                                .withTintColor(UIColor.toolbarIconColor, renderingMode: .alwaysOriginal))
            
            self.viewControllers = [dealsViewController, searchViewController]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleImage =  UIImageView(image: UIImage(named: "NavbarIcon"))
        titleImage.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImage
        if let selectedViewController = selectedViewController {
            changeNav(selectedViewController)
        }
    }
    
    func changeNav(_ selectedController: UIViewController) {
        if let dealsController = selectedController as? DealsViewController {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemSymbol: .ellipsisCircle).withTintColor(.white),
                                                                style: .plain,
                                                                target: dealsController,
                                                                action: #selector(dealsController.click))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
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
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        changeNav(viewController)
    }
}
