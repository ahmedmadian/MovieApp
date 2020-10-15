//
//  BaseServiceError.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

enum BaseServiceError: LocalizedError {
    
    case parsingError
    case serverError(message: String)
    case parametersNil
    case encodingFailed
    case missingURL
    
    var errorDescription: String? {
        switch self {
        case .parsingError: return "JSON Parsing Failure"
        case .serverError(let message): return "\(message)"
        case .parametersNil: return "Parameters were nil."
        case .encodingFailed: return "Parameter encoding failed."
        case .missingURL: return "URL is nil."
        }
    }
    
}
