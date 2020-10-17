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
    
    private lazy var tableView: UITableView = {
        let tabelView = UITableView()
        tabelView.backgroundColor = .clear
        tabelView.separatorStyle = .none
        tabelView.showsVerticalScrollIndicator = false
        tabelView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tabelView.register(SearchHistoryCell.self, forCellReuseIdentifier: String(describing: SearchHistoryCell.self))
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.showsHorizontalScrollIndicator = false
        return tabelView
    }()
    
    private lazy var recentHeaderView: UIView = {
        let headerView = UIView(frame: .zero)
        let recentLabel = UILabel()
        recentLabel.text = "Recent"
        recentLabel.textColor = .blue
        headerView.addSubview(recentLabel)
        recentLabel.pinToSuperview(forAtrributes: [.leading], constant: 16)
        recentLabel.pinToSuperview(forAtrributes: [.centerY])
        return headerView
    }()
    
    private lazy var searchBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearhButton))
        return button
    }()
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }
    
    // MARK: - View Configurations -
    
    private func setupView() {
        self.setupNavigationBar()
        self.setupViewLayout()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    private func setupViewLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.pinEdgesToSuperview()
    }
    
    // MARK: - Actions -
    
    @objc func didTapSearhButton() {
        self.presenter.handleShowSearchButton()
    }
    
}

// MARK: - TableViewDataSource -

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOrRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.presenter.viewMode {
            
        case .search:
            guard let historyCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchHistoryCell.self), for: indexPath) as? SearchHistoryCell else {
                fatalError("Unresolved Error, Couldn't load cell with identifier \(String(describing: MovieCell.self))")
            }
            self.presenter.config(searchCell: historyCell, at: indexPath)
            return historyCell
            
        case .result:
            guard let searchCell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell  else {
                fatalError("Unresolved Error, Couldn't load cell with identifier \(String(describing: MovieCell.self))")
            }
            self.presenter.config(cell: searchCell, at: indexPath)
            return searchCell
        }
    }
    
}

// MARK: - TableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.presenter.viewMode == .search ? 40 : (self.view.frame.height / 3)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.presenter.viewMode == .search ? recentHeaderView : nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.presenter.viewMode == .search ? 40 : 0
    }
}

// MARK: - SearchBarDelegate -

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchBarCancelButtonClicked()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.presenter.searchBarSearchButtonClicked(with: searchBar.text)
    }
    
}

// MARK: - Search View Output -

extension SearchViewController : SearchView {
    func setupViewFor(mode: ViewMode) {
        switch mode {
        case .search:
            self.navigationItem.titleView = self.searchBar
            self.navigationItem.rightBarButtonItem = nil
            self.searchBar.becomeFirstResponder()
        case .result:
            self.navigationItem.titleView = nil
            self.navigationItem.rightBarButtonItem = self.searchBarButtonItem
            self.searchBar.text = ""
        }
        self.tableView.reloadData()
        self.navigationItem.title = self.presenter.title
    }
    
    func searchBar(shouldBecomeFirstResponder: Bool) {
        _ = shouldBecomeFirstResponder ?
            self.searchBar.becomeFirstResponder() : self.searchBar.resignFirstResponder()
    }
    
    func updateSearchBarText(_ text: String) {
        self.searchBar.text = text
    }
    
    func updateSearchResult() {
        self.tableView.reloadData()
    }
}
