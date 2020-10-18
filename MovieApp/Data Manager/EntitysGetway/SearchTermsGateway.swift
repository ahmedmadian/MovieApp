//
//  SearchTermsGateway.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

typealias FetchSearchTermsEntityGatewayCompletionHandler = (Swift.Result<[String], Error>) -> Void

protocol SearchTermsGateway {
    
    func getAllSearchTerms(completionHandler: @escaping FetchSearchTermsEntityGatewayCompletionHandler)
    func save(searchTerms: [String])
    
}
