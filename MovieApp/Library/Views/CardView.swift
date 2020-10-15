//
//  CardView.swift
//  MovieApp
//
//  Created by Ahmed Madian on 10/15/20.
//  Copyright © 2020 Ahmed Madian. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // MARK: - View Hierarchy -
    private let shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "movie-ph"))
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name:"Avenir Next",size:30)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let labelsBackGround: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4953510123)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .clear
        setupViewLayout()
    }
    
    func setupViewLayout() {
        
        // container view
        addSubview(containerView)
        containerView.pinEdgesToSuperview()
        
        // add image
        self.containerView.addSubview(self.backgroundImageView)
        self.backgroundImageView.pinToSuperview(forAtrributes: [.leading, .top], constant: 4)
        self.backgroundImageView.pinToSuperview(forAtrributes: [.bottom, .trailing], constant: -4)
        
        
    
        
//
        
        
    }
}
