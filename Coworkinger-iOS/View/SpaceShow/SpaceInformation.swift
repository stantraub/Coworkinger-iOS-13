//
//  SpaceInformation.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/20/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class SpaceInformation: UIView {
    
    //MARK: - Properties
    
    var space: Space?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 25)
        return label
    }()
    
    private lazy var reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 16)
        label.text = "\(space?.rating ?? 0.0) (\(space?.reviewCount ?? 0))"
        return label
    }()
    
    private let reviewStar: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
        iv.setDimensions(height: 25, width: 25)
        return iv
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 16)
        label.text = "\(self.space?.location.city ?? ""), \(self.space?.location.state ?? "") \(self.space?.location.country ?? "")"
        return label
    }()
    
    //MARK: - Lifecycle
    
    init(space: Space) {
        super.init(frame: .zero)
        
        self.space = space
                                
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: leftAnchor)
        nameLabel.text = space.name
        
        let reviewStack = UIStackView(arrangedSubviews: [reviewStar, reviewsLabel])
        reviewStack.spacing = 6
        reviewStack.distribution = .fillProportionally
        
        addSubview(reviewStack)
        reviewStack.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, paddingTop: 15)
        
        addSubview(locationLabel)
        locationLabel.anchor(top: reviewStack.bottomAnchor, left: leftAnchor, paddingTop: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
}
