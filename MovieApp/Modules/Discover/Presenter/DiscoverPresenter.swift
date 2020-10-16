//
//  DiscoverPresenter.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class DiscoverPresenter {
    
    // MARK: - Private properties -
    
    private unowned var _view: DiscoverView
    private var _interactor: DiscoverInteraction
    private var _wireframe: DiscoverWireframe
    private var _items: [Movie]
    
    init(view: DiscoverView, interactor: DiscoverInteraction, wireframe: DiscoverWireframe) {
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
        self._items = []
    }
    
    private func fetchMovies() {
        self._interactor.getMovies { [unowned self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self._items = movies
                    self._view.updateView()
                case.failure(let error):
                    self._wireframe.showErrorAlert(with: error.localizedDescription)
                }
                self._view.hideLoader()
            }
        }
    }
}

extension DiscoverPresenter: DiscoverPresentation {
    var numberOfSections: Int {
        return 1
    }
    
    func viewDidLoad() {
        self._view.showLoader()
        self.fetchMovies()
    }
    
    func numberOrItems(in section: Int) -> Int {
        return self._items.count
    }
    
    func config(cell: MovieItemView, at indexPath: IndexPath) {
        let viewModel = MovieViewModel(movie: self._items[indexPath.row])
        cell.configView(with: viewModel)
    }
}
