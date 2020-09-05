//
//  SpaceCell.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/18/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import SDWebImage

class SpaceCell: UICollectionViewCell {
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 18)
        return label
    }()
    
    private let reviewStar: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "star.circle.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.systemBlue)
        iv.setDimensions(height: 20, width: 20)
        return iv
    }()
    
    private let reviewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 16)
        return label
    }()


    
    var space: SearchCardCell? {
        didSet {
            configureSpace()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .systemGroupedBackground
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
        layer.shadowRadius = 3

        layer.cornerRadius = 22
        layer.masksToBounds = true
    }
    
    func configureSpace() {
        guard let space = space else { return }
 
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.sd_setImage(with: URL(string: space.imageUrl ?? "https://www.dwrl.utexas.edu/wp-content/uploads/2017/02/yelp-logo-vector.jpg"))
        
        addSubview(imageView)
        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, width: frame.width, height: frame.height / 2)
        imageView.setDimensions(height: frame.width / 2, width: frame.width)
        
        let reviewInfoStack = UIStackView(arrangedSubviews: [reviewStar, reviewsLabel])
        reviewInfoStack.axis = .horizontal
        reviewInfoStack.spacing = 6
        reviewsLabel.text = "\(space.rating ?? 0.0) (\(space.reviewCount ?? 0))"
        addSubview(reviewInfoStack)
        reviewInfoStack.anchor(top: imageView.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 10)
        
        addSubview(titleLabel)
        titleLabel.text = space.name
        titleLabel.anchor(top: reviewInfoStack.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)
        
        

    
    }
}
