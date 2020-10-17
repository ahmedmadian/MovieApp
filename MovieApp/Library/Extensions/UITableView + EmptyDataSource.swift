//
//  UITableView + EmptyDataSource.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/17/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

extension UITableView {
    func emptyDataPresentation() {
        
        let imageView = UIImageView(image: UIImage(named: "no-data"))
        imageView.contentMode = .center
        
        self.backgroundView = imageView
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
