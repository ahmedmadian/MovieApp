//
//  SearchHistoryCell.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class SearchHistoryCell: UITableViewCell {
   
    private let searchTermLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViewLayout()
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        
        self.addSubview(searchTermLabel)
        self.searchTermLabel.pinToSuperview(forAtrributes: [.leading], constant: 16)
        self.searchTermLabel.pinToSuperview(forAtrributes: [.centerY])
        
    }
}

extension SearchHistoryCell: SearchTermItemView {
    func configView(with searchTerm: String) {
        self.searchTermLabel.text = searchTerm
    }
}
