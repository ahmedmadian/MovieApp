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
    private var _items: [Movie]
    
    // MARK: - Life Cycle
    
    init(view: SearchView, interactor: SearchInteraction, wireframe: SearchWireframe) {
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
        self._items = []
    }
    
    private func searchForMovies(with text: String) {
        self._interactor.searchForMovie(with: text) { [unowned self] (result)in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self._items = movies
                    print(self._items.count)
                case.failure(let error):
                    self._wireframe.showErrorAlert(with: error.localizedDescription)
                }
                self._view.hideLoader()
            }
        }
    }
    
}

extension SearchPresenter: SearchPresentation {
    
    func viewWillAppear(animated: Bool) {
        self._view.searchBar(shouldBecomeFirstResponder: true)
    }
    
    func searchBarCancelButtonClicked() {
        self._view.searchBar(shouldBecomeFirstResponder: false)
        self._view.updateSearchBarText("")
    }
    
    func searchBarSearchButtonClicked(with text: String?) {
        self._view.searchBar(shouldBecomeFirstResponder: false)
        guard let searchText = text else { return }
        self._view.showLoader()
        self.searchForMovies(with: searchText)
    }
       
    
}
