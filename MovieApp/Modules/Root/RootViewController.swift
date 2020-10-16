//
//  RootViewController.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {

    struct Constants {
        static let insetsBottom: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? -8 :  0
        static let insetsTop: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 8 :  0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.barTintColor  = .black
        self.tabBar.tintColor = .white
        self.tabBar.unselectedItemTintColor = .lightGray
        self.tabBar.isTranslucent = true
        
        let a = DiscoverWireframe().viewController
        a.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        
        

        let b = UINavigationController(rootViewController: SearchWireframe().viewController)
        b.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        
        
        self.setViewControllers([a,b], animated: true)
        
    }
    
}
