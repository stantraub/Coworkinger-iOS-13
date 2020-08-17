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
    
    private var profileImage: UIImage?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Coworkinger"
        label.font = UIFont(name: "Avenir", size: 36)
        label.textColor = .systemBlue
        return label
    }()
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemBlue
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.clipsToBounds = true
        return button
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
        let placeholder = NSAttributedString(string: "Email", attributes: [.font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                                                            .foregroundColor: UIColor.darkGray])
        tf.attributedPlaceholder = placeholder
        tf.font = UIFont(name: "Avenir", size: 16)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        let placeholder = NSAttributedString(string: "Password", attributes: [.font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                                                            .foregroundColor: UIColor.darkGray])
        tf.attributedPlaceholder = placeholder
        tf.isSecureTextEntry = true
        tf.font = UIFont(name: "Avenir", size: 16)
        return tf
    }()
    
    private let fullnameTextField: UITextField = {
        let tf = UITextField()
        let placeholder = NSAttributedString(string: "Full Name", attributes: [.font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                                                            .foregroundColor: UIColor.darkGray])
        tf.attributedPlaceholder = placeholder
        tf.font = UIFont(name: "Avenir", size: 16)
        return tf
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        let placeholder = NSAttributedString(string: "Username", attributes: [.font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                                                            .foregroundColor: UIColor.darkGray])
        tf.attributedPlaceholder = placeholder
        tf.font = UIFont(name: "Avenir", size: 16)
        return tf
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let title = NSMutableAttributedString(string: "Already have an account? ", attributes: [.foregroundColor: UIColor.darkGray,
                                                                                                .font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16)])
        title.append(NSAttributedString(string: "Sign in.", attributes: [.foregroundColor: UIColor.systemBlue,
                                                                         .font: UIFont(name: "Avenir-Heavy", size: 16) ?? UIFont.systemFont(ofSize: 16)]))
        
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
    
    @objc func handleSelectPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @objc func handleSignup() {
        print("Handle signup here...")
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
        
        view.addSubview(selectPhotoButton)
        selectPhotoButton.anchor(top: titleLabel.bottomAnchor, paddingTop: 20)
        selectPhotoButton.centerX(inView: view)
        selectPhotoButton.setDimensions(height: 250, width: 250)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,
                                                   passwordContainerView,
                                                   fullnameContainerView,
                                                   usernameContainerView,
                                                   registerButton])
        stack.axis = .vertical
        stack.spacing = 32
        stack.distribution = .fillProportionally
        
        view.addSubview(stack)
        stack.anchor(top: selectPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 15, paddingLeft: 32, paddingRight: 32)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
}

//MARK: - UIImagePickerControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage = image
        selectPhotoButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        selectPhotoButton.layer.cornerRadius = 250 / 2
        selectPhotoButton.imageView?.contentMode = .scaleAspectFill
        
        dismiss(animated: true, completion: nil)
    }
}
