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
    
    private lazy var tableView: UITableView = {
        let tabelView = UITableView()
        tabelView.backgroundColor = .clear
        tabelView.separatorStyle = .none
        tabelView.showsVerticalScrollIndicator = false
        tabelView.rowHeight = (self.view.frame.height) / 3
        tabelView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tabelView.dataSource = self
        tabelView.delegate = self
        tabelView.showsHorizontalScrollIndicator = false
        return tabelView
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width , height: 40))
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.color = .red
        footerView.addSubview(spinner)
        spinner.pinToSuperview(forAtrributes: [.centerX, .centerY])
        spinner.startAnimating()
        return footerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.presenter.viewDidLoad()
    }
    
    private func setupView() {
        self.navigationController?.navigationBar.isHidden = true
        self.setupViewLayout()
    }
    
    private func setupViewLayout() {
        self.view.addSubview(self.tableView)
        self.tableView.pinEdgesToSuperview()
    }
    
}

// MARK: - UITableViewDataSource -

extension DiscoverViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOrRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell else {
            fatalError("Unresolved Error, Couldn't load cell with identifier \(String(describing: MovieCell.self))")
        }
        
        self.presenter.config(cell: cell, at: indexPath)
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate -

extension DiscoverViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - (scrollView.frame.size.height * 4) {
            self.presenter.didScrollToEnd()
        }
    }
}

// MARK: - DiscoverView -

extension DiscoverViewController: DiscoverView {
    
    func updateView() {
        self.tableView.reloadData()
    }
    
    func showTableViewFooter() {
        self.tableView.tableFooterView = self.footerView
    }
    
    func hideTableViewFooter() {
        self.tableView.tableFooterView = nil
    }
    
}


