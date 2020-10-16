//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    let _movie: Movie
    
    init(movie: Movie) {
        self._movie = movie
    }
}

extension MovieViewModel: MoviePresentable {
    var name: String {
        return self._movie.title
    }
    
    var thumbnailURL: URL? {
        let fileSize = "w300"
        let urlString = "\(Enviroment.current.baseImageURL)\(fileSize)/\(self._movie.posterPath ?? "")"
       return URL(string: urlString)
    }
    
    var releaseDate: String {
        return self._movie.releaseDate
    }
    
    var overView: String {
        return self._movie.overview
    }
}
