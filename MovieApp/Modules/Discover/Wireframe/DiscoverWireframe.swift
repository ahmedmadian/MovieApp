//
//  DiscoverWireframe.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class DiscoverWireframe: BaseWireframe {
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = DiscoverViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = DiscoverInteractor(moviesService: MoviesRemoteGatewayToTMDB())
        
        let presenter = DiscoverPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        
        moduleViewController.presenter = presenter
    }
}
