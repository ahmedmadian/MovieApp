//
//  SearchVIPERContract.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/16/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol SearchView: Viewable {
    func setupViewFor(mode: ViewMode)
    func searchBar(shouldBecomeFirstResponder: Bool)
    func updateSearchBarText(_ text: String)
    func updateSearchResult()
}

protocol SearchPresentation: Presentable {
    var viewMode: ViewMode { get }
    var title: String { get }
    func handleShowSearchButton()
    func searchBarCancelButtonClicked()
    func searchBarSearchButtonClicked(with text: String?)
    var numberOfSections: Int { get }
    func numberOrRows(in section: Int) -> Int
    func config(cell: MovieItemView, at indexPath: IndexPath)
    func config(searchCell: SearchTermItemView, at indexPath: IndexPath)
    func didSelectRow (at indexPath: IndexPath)
}

protocol SearchInteraction: Interactable {
    func searchForMovie(with searchTerm: String, page: Int, _ completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol SearchWireframeInterface: Wireframeable {
}

protocol SearchTermItemView {
    func configView(with searchTerm: String)
}

enum ViewMode {
    case search
    case result
}
