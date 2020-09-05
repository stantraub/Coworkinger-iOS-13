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
    
    private let imageView = UIImageView()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.setDimensions(height: 30, width: 30)
        return button
    }()
    
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
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: 16)
        return label
    }()
    
    private let phoneLabel: UILabel = {
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
    
    @objc func saveButtonTapped() {
        print("save this space")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        
    }
    
    func configureSpace() {
        guard let space = self.space else { return }
 
        addSubview(imageView)
        imageView.sd_setImage(with: URL(string: space.imageUrl ?? "https://www.dwrl.utexas.edu/wp-content/uploads/2017/02/yelp-logo-vector.jpg"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height / 2)
//        imageView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, width: frame.width, height: frame.height / 2)

        addSubview(saveButton)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.anchor(top: topAnchor, right: rightAnchor, paddingTop: 10, paddingRight: 10)

        let reviewInfoStack = UIStackView(arrangedSubviews: [reviewStar, reviewsLabel])
        reviewInfoStack.axis = .horizontal
        reviewInfoStack.spacing = 6
        reviewsLabel.text = "\(space.rating ?? 0.0) (\(space.reviewCount ?? 0))"
        addSubview(reviewInfoStack)
        reviewInfoStack.anchor(top: imageView.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 10)

        addSubview(titleLabel)
        titleLabel.text = space.name
        titleLabel.anchor(top: reviewInfoStack.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)

        phoneLabel.text = space.phone
        addSubview(phoneLabel)
        phoneLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)

        locationLabel.text = "\(space.city ?? "") · \(space.country ?? "")"
        addSubview(locationLabel)
        locationLabel.anchor(top: phoneLabel.bottomAnchor, left: leftAnchor, paddingTop: 5, paddingLeft: 10)
    }
}
