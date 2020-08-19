//
//  ProfileHeader.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/18/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class ProfileHeader: UIView {
    
    //MARK: - Properties
    
    var user: User
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.cornerRadius = 70 / 2
        iv.setDimensions(height: 70, width: 70)
        iv.sd_setImage(with: user.profileImageUrl)
        return iv
    }()
    
    lazy var welcomeText: UILabel = {
        let label = UILabel()
        label.text = "Hi, I'm \(user.fullname)"
        label.font = UIFont(name: "Avenir-Heavy", size: 28)
        return label
    }()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        let stack = UIStackView(arrangedSubviews: [welcomeText, profileImageView])
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 20, paddingRight: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
