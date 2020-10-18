//
//  Enviroment.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum Enviroment: String {
    
    // MARK: - Enviroments
    
    case staging = "Staging"
    
    // MARK: - Current Enviroment
    
    static let current: Enviroment = {
        return .staging
    }()
    
    var baseImageURL: String {
        switch self {
        case .staging:
            return "https://image.tmdb.org/t/p/"  
        }
    }
    
}
