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
    
    private let _moviesService: MoviesRemoteService
    
    // MARK: - Life Cycle
    
    init(moviesService: MoviesRemoteService) {
        self._moviesService = moviesService
    }
    
}

extension SearchInteractor: SearchInteraction {
    func searchForMovie(with searchTerm: String, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        self._moviesService.searchforMovie(with: searchTerm) { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
