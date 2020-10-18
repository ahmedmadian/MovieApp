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
    private var _pageNumber = 1
    var _currentSearchText = "" {
        didSet {
            if !self._searchTerms.contains(_currentSearchText) { self._searchTerms.insert(_currentSearchText, at: 0)}
        }
    }
    private var _viewMode: ViewMode = .search {
        didSet {
            self._view.setupViewFor(mode: self._viewMode)
        }
    }
    
    // MARK: - Life Cycle
    
    init(view: SearchView,
         interactor: SearchInteraction,
         wireframe: SearchWireframe) {
        
        self._view = view
        self._interactor = interactor
        self._wireframe = wireframe
        self._items = []
        self._searchTerms = []
    }
    
    private func loadSearchHistory() {
        self._interactor.getSearchTerms { (result) in
            switch result {
            case .success(let data):
                self._searchTerms = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveSearchHistory() {
        self._interactor.save(searchTerms: Array(self._searchTerms))
    }
    
    private func searchMovie(with text: String) {
        self._viewMode = .result
        self._view.showLoader()
        self._interactor.searchForMovie(with: text, page: _pageNumber) { [unowned self] (result)in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self._items = movies
                    self._currentSearchText = text
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
   
    /// Navigation Bar Title
    var title: String {
        switch self._viewMode {
        case .search:
            return "Search Movies"
        case .result:
            return "Movies"
        }
    }
    
    /// View Mode
    var viewMode: ViewMode {
        return self._viewMode
    }
    
    /// ViewController Life Cycle
    func viewDidLoad() {
        self._viewMode = .search
        self.loadSearchHistory()
    }
    
    func viewWillDisappear(animated: Bool) {
        self.saveSearchHistory()
    }
    
    /// Nvigation Bar Button
    func handleShowSearchButton() {
        self._viewMode = .search
    }
    
    /// Search Bar
    func searchBarCancelButtonClicked() {
        self._viewMode = .result
    }
    
    func searchBarSearchButtonClicked(with text: String) {
        self.searchMovie(with: text)
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
    
    /// Cell Configurations
    func config(cell: MovieItemView, at indexPath: IndexPath) {
        let viewModel = MovieViewModel(movie: self._items[indexPath.row])
        cell.configView(with: viewModel)
    }
    
    func config(searchCell: SearchTermItemView, at indexPath: IndexPath) {
        searchCell.configView(with: self._searchTerms[indexPath.row])
    }
    
    /// Cell Selection
    func didSelectRow(at indexPath: IndexPath) {
        if self._viewMode == .result { return }
        self.searchMovie(with: self._searchTerms[indexPath.row])
    }
}
