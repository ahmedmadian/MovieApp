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
    
    private unowned let _view: SearchView
    private let _interactor: SearchInteraction
    private let _wireframe: SearchWireframe
    private var _items: [Movie]
    private var _searchTerms: [String]
    private var _viewMode: ViewMode = .search {
        didSet {
            self._view.setupViewFor(mode: self._viewMode)
        }
    }
    private var _selectedSearchTerm: String = ""
    
    // MARK: - Life Cycle
    
    init(view: SearchView, interactor: SearchInteraction, wireframe: SearchWireframe) {
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
        self._items = []
        self._searchTerms = ["Mad", "Misssion", "Ali"]
    }
    
    private func searchForMovies(with text: String) {
        self._view.showLoader()
        self._interactor.searchForMovie(with: text, page: 1) { [unowned self] (result)in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self._items = movies
                    self._view.updateSearchResult()
                case.failure(let error):
                    self._wireframe.showErrorAlert(with: error.localizedDescription)
                }
                self._view.hideLoader()
            }
        }
    }
    
}

// MARK: - View Inputs to Presnter

extension SearchPresenter: SearchPresentation {
    
    func viewDidLoad() {
        self._viewMode = .search
    }
    
    var title: String {
        switch self._viewMode {
        case .search:
            return "Search"
        case .result:
            return self._selectedSearchTerm == "" ? "Movies" : "Result of \'\(self._selectedSearchTerm)\'"
        }
    }
    
    func handleShowSearchButton() {
        self._viewMode = .search
    }
    
    var viewMode: ViewMode {
        return self._viewMode
    }
    
    func searchBarCancelButtonClicked() {
        self._viewMode = .result
    }
    
    func searchBarSearchButtonClicked(with text: String?) {
        guard let searchText = text else { return }
        self._selectedSearchTerm = searchText
        self._viewMode = .result
        self.searchForMovies(with: searchText)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOrRows(in section: Int) -> Int {
        switch self._viewMode {
        case .search:
            return self._searchTerms.count
        case .result:
            return self._items.count
        }
    }
    
    func config(cell: MovieItemView, at indexPath: IndexPath) {
        let viewModel = MovieViewModel(movie: self._items[indexPath.row])
        cell.configView(with: viewModel)
    }
    
    func config(searchCell: SearchTermItemView, at indexPath: IndexPath) {
        searchCell.configView(with: self._searchTerms[indexPath.row])
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if self._viewMode == .result { return }
        self._selectedSearchTerm = self._searchTerms[indexPath.row]
        self._viewMode = .result
        self.searchForMovies(with: self._searchTerms[indexPath.row])
    }
    
}
