//
//  SpacePicture.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/20/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class SpaceShowPhotoCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    let imageView = UIImageView()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


    //MARK: - Helpers
    
//    func configureActionButtons() {
//        addSubview(backButton)
//        backButton.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingLeft: 30)
//        backButton.setDimensions(height: 30, width: 30)
//
//        addSubview(saveButton)
//        saveButton.anchor(top: safeAreaLayoutGuide.topAnchor, right: rightAnchor, paddingRight: 30)
//        saveButton.setDimensions(height: 30, width: 30)
//
//    }
    

