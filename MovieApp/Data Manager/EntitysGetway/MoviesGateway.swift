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
