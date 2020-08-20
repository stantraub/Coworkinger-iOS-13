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
    
    var firstName: String {
        return user.fullname.components(separatedBy: " ").first!
    }
    
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
        label.text = "Hey, I'm \(self.firstName)"
        label.font = UIFont(name: "Avenir-Heavy", size: 28)
        return label
    }()
    
    private lazy var separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return view
    }()
    
    //MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
                        
        let stack = UIStackView(arrangedSubviews: [welcomeText, profileImageView])
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 30, paddingLeft: 20, paddingRight: 20)
        
        addSubview(separatorLine)
        separatorLine.anchor(top: topAnchor)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
