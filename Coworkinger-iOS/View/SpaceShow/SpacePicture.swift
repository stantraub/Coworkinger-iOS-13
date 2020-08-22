//
//  SpacePicture.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/20/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import SDWebImage

protocol SpacePictureDelegate: class {
    func handleBackButtonTapped()
}

class SpacePicture: UIView {
    
    //MARK: - Properties
    
    var imageUrl: URL?
    
    weak var delegate: SpacePictureDelegate?
    
    private let gradientLayer = CAGradientLayer()
    
    lazy var photo: UIImageView = {
        let iv = UIImageView()
        iv.sd_setImage(with: imageUrl)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init(photo: String) {
        super.init(frame: .zero)
        self.imageUrl = URL(string: photo)
        
        configurePhoto()
        configureGradientLayer()
        configureActionButtons()
    }
    
    override func layoutSubviews() {
        gradientLayer.frame = self.frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleBackButtonTapped() {
        delegate?.handleBackButtonTapped()
    }
    
    @objc func handleLikeTapped() {
        print("DEBUG: Handle save tapped here...")
    }
    
    //MARK: - Helpers
    
    func configurePhoto() {
        addSubview(photo)
        photo.fillSuperview()
    }
    
    func configureActionButtons() {
        addSubview(backButton)
        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingLeft: 30)
        backButton.setDimensions(height: 30, width: 30)
        
        addSubview(saveButton)
        saveButton.anchor(top: safeAreaLayoutGuide.topAnchor, right: rightAnchor, paddingRight: 30)
        saveButton.setDimensions(height: 30, width: 30)

    }
    
    func configureGradientLayer() {
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.5]
        layer.addSublayer(gradientLayer)
    }
}
