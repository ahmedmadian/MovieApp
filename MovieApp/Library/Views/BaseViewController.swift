//
//  BaseViewController.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .large
        self.view.addSubview(activity)
        activity.pinToSuperview(forAtrributes: [.centerX, .centerY])
        return activity
    }()
    
}

extension BaseViewController: Viewable {
    func showLoader() {
        view.bringSubviewToFront(activity)
        activity.isHidden = false
        activity.startAnimating()
    }
    
    func hideLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
