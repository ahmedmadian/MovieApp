//
//  SearchPresenter.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/16/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class SearchPresenter {
    
    // MARK: - Private properties -
    
    private unowned var _view: SearchView
    private var _interactor: SearchInteraction
    private var _wireframe: SearchWireframe
    
    // MARK: - Life Cycle
    
    init(view: SearchView, interactor: SearchInteraction, wireframe: SearchWireframe) {
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
    }
    
}

extension SearchPresenter: SearchPresentation {
    
}
