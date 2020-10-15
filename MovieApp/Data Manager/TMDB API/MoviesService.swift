//
//  MoviesService.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class MoviesRemoteService: BaseService {

    
    func getDiscoverMovies(completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        let endPoint: TMDBClient.TMDBEndPoint = .discover
        self.execute(endPoint: endPoint) { (result: Result<GenericResoponse<Movie>, Error>) in
            
            switch result {
            case .success(let data):
                completionHandler(.success(data.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    func searchforMovie(with searchTerm: String, completionHandler: @escaping (Swift.Result<[Movie], Error>) -> Void) {
        let endPoint: TMDBClient.TMDBEndPoint = .search(searchTerm)
        self.execute(endPoint: endPoint) { (result: Result<GenericResoponse<Movie>, Error>) in
            
            switch result {
            case .success(let data):
                completionHandler(.success(data.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
}


struct GenericResoponse<Model: Codable>: Codable {
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Model]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
