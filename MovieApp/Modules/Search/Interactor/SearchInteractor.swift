//
//  SearchInteractor.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/16/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class SearchInteractor {
    
    // MARK: - Private Properties -
    
    private let _moviesGateway: MoviesGateway
    private let _searchTermsGateway: SearchTermsGateway
    
    // MARK: - Life Cycle
    
    init(moviesService: MoviesGateway, searchTermsGateway: SearchTermsGateway) {
        self._moviesGateway = moviesService
        self._searchTermsGateway = searchTermsGateway
    }
    
}

extension SearchInteractor: SearchInteraction {
    
    func searchForMovie(with searchTerm: String, page: Int, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        self._moviesGateway.searchforMovie(with: searchTerm, page: page) { result in
           completion(result)
        }
    }
    
    func getSearchTerms(_ completion: @escaping FetchSearchTermsEntityGatewayCompletionHandler) {
        self._searchTermsGateway.getAllSearchTerms { (result) in
            completion(result)
        }
    }
    
    func save(searchTerms: [String]) {
        self._searchTermsGateway.save(searchTerms: searchTerms)
    }
    
}
