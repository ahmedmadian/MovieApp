//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {
    
    // MARK: - Public properties -
    
    var presenter: SearchPresentation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension SearchViewController : SearchView {
    
}
