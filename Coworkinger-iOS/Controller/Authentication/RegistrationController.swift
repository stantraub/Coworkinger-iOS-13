//
//  RegistrationController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 7/27/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coworkinger"
        label.font = UIFont(name: "Avenir", size: 36)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var emailContainerView: UIView = {
        let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_mail_outline_white_2x"), textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField)
           return view
    }()
    
    private lazy var fullnameContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x-1"), textField: fullnameTextField)
           return view
    }()
    
    private lazy var usernameContainerView: UIView = {
           let view = UIView().inputContainerView(image: #imageLiteral(resourceName: "ic_person_outline_white_2x-1"), textField: usernameTextField)
           return view
    }()
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name"
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        return tf
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Already have an account? ", attributes: [.foregroundColor: UIColor.darkGray,
                                                                                                .font: UIFont.systemFont(ofSize: 16)])
        title.append(NSAttributedString(string: "Sign in.", attributes: [.foregroundColor: UIColor.systemBlue,
                                                                         .font: UIFont.boldSystemFont(ofSize: 16)]))
        
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(switchToLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func switchToLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullnameContainerView, usernameContainerView])
        stack.axis = .vertical
        stack.spacing = 24
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
    

}
