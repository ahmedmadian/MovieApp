//
//  DiscoverInteractor.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class DiscoverInteractor {
    
    private let _moviesService: MoviesRemoteService
    
    init(moviesService: MoviesRemoteService) {
        self._moviesService = moviesService
    }
}

extension DiscoverInteractor: DiscoverInteraction {
    func getMovies(page: Int, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
        self._moviesService.getDiscoverMovies(page: page){ (result) in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
