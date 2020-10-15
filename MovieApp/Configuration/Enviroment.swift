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
       
//        guard let value = Bundle.main.infoDictionary?["Configuration"] as? String else {
//            fatalError("Can't found Configuration")
//        }
//
//        guard let rawValue = value.split(separator: "/").last else {
//            fatalError("Invalid Configuration")
//        }
//
//        guard let enviroment = Enviroment(rawValue: "\(rawValue)") else {
//            fatalError("Invalid Enviroment")
//        }
//
        return .staging
    }()
    
}
