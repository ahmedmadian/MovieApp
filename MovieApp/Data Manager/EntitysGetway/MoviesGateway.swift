//
//  MoviesGateway.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

typealias FetchMoviesEntityGatewayCompletionHandler = (Swift.Result<[Movie], Error>) -> Void

protocol MoviesGateway {
    func getDiscoverMovies(page: Int, completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler)
    func searchforMovie(with searchTerm: String, page: Int, completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler)
}

class MoviesRemoteGatewayToTMDB: BaseService {
    
}

extension MoviesRemoteGatewayToTMDB: MoviesGateway {
    
    func getDiscoverMovies(page: Int, completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler) {
        let endPoint: TMDBClient.TMDBEndPoint = .discover(page: page)
        self.execute(endPoint: endPoint) { (result: Result<GenericResoponse<Movie>, Error>) in
            
            switch result {
            case .success(let data):
                completionHandler(.success(data.results))
            case .failure(let error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    func searchforMovie(with searchTerm: String, page: Int, completionHandler: @escaping FetchMoviesEntityGatewayCompletionHandler) {
        let endPoint: TMDBClient.TMDBEndPoint = .search(searchTerm: searchTerm, page: page)
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

