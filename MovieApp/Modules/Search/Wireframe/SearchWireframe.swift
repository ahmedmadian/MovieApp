//
//  SearchWireframe.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/16/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class SearchWireframe: BaseWireframe {
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = SearchViewController()
        super.init(viewController: moduleViewController)
        
        let interactor = SearchInteractor(moviesService: MoviesRemoteService())
        
        let presenter = SearchPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        
        moduleViewController.presenter = presenter
    }
    
}
