//
//  RootViewController.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor  = .black
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.isTranslucent = true
        
        let mostRecentRoute = UINavigationController()
        mostRecentRoute.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        mostRecentRoute.setRootRoute(DiscoverWireframe())
        
        let searchRoute = UINavigationController()
        searchRoute.tabBarItem =  UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchRoute.setRootRoute(SearchWireframe())
        
        
        self.setViewControllers([mostRecentRoute,searchRoute], animated: true)
        
    }
    
}
