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
    
    func getSearchHistory(completionHandler: @escaping FetchSearchTermsEntityGatewayCompletionHandler)
    func save(searchTerms: [String])
    
}

class SearchTermLocalGetway {
    
    private let SEARCH_KEY = "com.cornetElevated.searchTerms"
    private let storage: CodableStorage
    
    init() {
        let path = URL(fileURLWithPath: NSTemporaryDirectory())
        let disk = DiskStorage(path: path)
        storage = CodableStorage(storage: disk)
    }
}

extension SearchTermLocalGetway: SearchTermsGateway {
    
    func getSearchHistory(completionHandler: @escaping FetchSearchTermsEntityGatewayCompletionHandler) {
        
        do {
            let result: [String] = try self.storage.fetch(for: SEARCH_KEY)
            completionHandler(.success(result))
        } catch {
            completionHandler(.failure(StorageError.notFound))
        }
    }
    
    func save(searchTerms: [String]) {
        
        do{
            try self.storage.save(searchTerms, for: SEARCH_KEY)
        } catch {
            print(error)
        }
        
    }
}
