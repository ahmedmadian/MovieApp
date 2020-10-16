//
//  DiscoverVIPERContract.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

protocol DiscoverView: Viewable {
    func updateView()
}

protocol DiscoverPresentation: Presentable {
    var numberOfSections: Int { get }
    func numberOrItems(in section: Int) -> Int
    func config(cell: MovieItemView, at indexPath: IndexPath)
}

protocol DiscoverInteraction: Interactable {
     func getMovies(_ completion: @escaping (Result<[Movie], Error>) -> Void)
}

protocol DiscoverWireframeInterface: Wireframeable {
}


protocol MovieItemView {
    func configView(with viewModel: MoviePresentable)
}

protocol MoviePresentable {
    
    var name: String { get }
    var thumbnailURL: URL? { get }
    var releaseDate: String { get }
    var overView: String { get }
    
}
