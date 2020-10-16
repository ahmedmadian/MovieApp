//
//  DiscoverViewController.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseViewController {
    
    // MARK: - Public properties -
    
    var presenter: DiscoverPresentation!

    // MARK: - View Hierachy -
    
    private lazy var _collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: String(describing: MovieCell.self))
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    }()
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        let height = (self.view.frame.height - 30) / 3
        let width = (self.view.frame.width - 30) / 2
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
        
    }
    
    private func setupView() {
        self.setupViewLayout()
    }
    
    private func setupViewLayout() {
        self.view.addSubview(self._collectionView)
        self._collectionView.pinEdgesToSuperview()
    }
    
}

extension DiscoverViewController: DiscoverView {
    
    func updateView() {
        self._collectionView.reloadData()
    }
    
}

extension DiscoverViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.presenter.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOrItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            fatalError("Unresolved Error, Couldn't load cell with identifier \(String(describing: MovieCell.self))")
        }
        
        self.presenter.config(cell: cell, at: indexPath)
        
        return cell
    }
    
    
}


