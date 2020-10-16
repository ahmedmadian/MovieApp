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
    
    // MARK: - View Hierachy -
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        searchBar.searchTextField.tintColor = .lightGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray

        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
//        self.setupViewLayout()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        
        self.navigationItem.titleView = self.searchBar
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Search"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear(animated: animated)
    }
    
    private func setupViewLayout() {
        self.view.addSubview(self.searchBar)
        self.searchBar.pinToSuperview(forAtrributes: [.top], constant: 10)
        self.searchBar.pinToSuperview(forAtrributes: [.leading, .trailing])
    }
    
}

extension SearchViewController: UISearchBarDelegate {
 
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchBarSearchButtonClicked(with: searchBar.text)
    }
    
}

extension SearchViewController : SearchView {
    
    func searchBar(shouldBecomeFirstResponder: Bool) {
        _ = shouldBecomeFirstResponder ?
            self.searchBar.becomeFirstResponder() : self.searchBar.resignFirstResponder()
    }
    
    func updateSearchBarText(_ text: String) {
        self.searchBar.text = text
    }
    
}
