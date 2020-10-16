//
//  SearchVIPERContract.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/16/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol SearchView: Viewable {
    func searchBar(shouldBecomeFirstResponder: Bool)
    func updateSearchBarText(_ text: String)
}

protocol SearchPresentation: Presentable {
    func searchBarCancelButtonClicked()
    func searchBarSearchButtonClicked(with text: String?)
}

protocol SearchInteraction: Interactable {
    func searchForMovie(with searchTerm: String, _ completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol SearchWireframeInterface: Wireframeable {
}
