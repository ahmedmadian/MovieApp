//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private var movieImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "movie-ph"))
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewLayout()
        self.backgroundColor = .red
        self.layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        self.addSubview(movieImageView)
        self.movieImageView.pinToSuperview(forAtrributes: [.leading, .top], constant: 4)
        self.movieImageView.pinToSuperview(forAtrributes: [.bottom, .trailing], constant: -4)
        
    }
    
}

extension MovieCell: MovieItemView {
    func configView(with viewModel: MoviePresentable) {
        if let url = viewModel.thumbnailURL {
             self.movieImageView.loadImageFromUrl(url: url)
        }
        
    }
    
    
}
