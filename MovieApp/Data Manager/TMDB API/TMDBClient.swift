//
//  TMDBClient.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class TMDBClient {
    
    private static let TMDB_API_KEY = "1d3b49863ebdc2ac45c28f07446bdd39"
    private static let TMDB_API_Read_Access_Token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiYTNkOTkzZTNmOGJhOGIzNDJmNTAyZjllZDY5ZTUzM iIsInN1YiI6IjVmMTQzMTViMWM2YWE3MDAzNTgxN2U2ZCIsInNjb3BlcyI6WyJhcGlfcmVhZ CJdLCJ2ZXJza W9uIjoxfQ.1R5tfdhb_LC_MqR1SrTDTtJKvWZsSQGC72WFlF4oiOU"
    
    init() {
    }
    
}

extension TMDBClient {
    
    // MARK: - API EndPoints
    enum TMDBEndPoint {
        case discover
        case search(String)
    }
    
}

// MARK: - Endpoint Configurations

extension TMDBClient.TMDBEndPoint: EndPointType {
    
    var environmentBaseURL : String {
        switch Enviroment.current {
        case .staging:
            return "https://api.themoviedb.org/3/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .discover:
            return "discover/movie"
        case .search:
            return "search/movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .discover:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key":TMDBClient.TMDB_API_KEY])
        case .search(let searchTerm):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["query":searchTerm])
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Authorization" : TMDBClient.TMDB_API_Read_Access_Token]
    }
    
}
