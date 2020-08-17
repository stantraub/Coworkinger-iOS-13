//
//  LoginController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 7/27/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import JGProgressHUD
import Firebase

class LoginController: UIViewController {
    
    //MARK: - Properties
    
    private var viewModel = LoginViewModel()
    
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
    
    private let emailTextField: UITextField = {
        let tf = UITextField()
        let placeholder = NSAttributedString(string: "Email", attributes: [.font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                                                            .foregroundColor: UIColor.darkGray])
        tf.attributedPlaceholder = placeholder
        tf.font = UIFont(name: "Avenir", size: 16)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        let placeholder = NSAttributedString(string: "Password", attributes: [.font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16),
                                                                            .foregroundColor: UIColor.darkGray])
        tf.attributedPlaceholder = placeholder
        tf.font = UIFont(name: "Avenir", size: 16)
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 16)
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemTeal
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        var title = NSMutableAttributedString(string: "Don't have an account?", attributes: [.foregroundColor: UIColor.darkGray,
                                                                                             .font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16)])
        title.append(NSAttributedString(string: " Sign up.", attributes: [.foregroundColor: UIColor.systemBlue,
                                                                          .font: UIFont(name: "Avenir-Heavy", size: 16) ?? UIFont.systemFont(ofSize: 16)]))
        button.setAttributedTitle(title, for: .normal)
        button.addTarget(self, action: #selector(switchToSignup), for: .touchUpInside)
        return button
    }()
    

    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        logout()
        configureUI()
        configureTextFieldObservers()
    }
    
    //MARK: - Selectors
    
    @objc func switchToSignup() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let hud = JGProgressHUD(style: .dark)
        hud.show(in: view)
        
        AuthService.logUserIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("DEBUG: \(error.localizedDescription)")
                hud.dismiss()
                return
            }
            hud.dismiss()
            print("DEBUG: Logged \(email) in successfully")
            let controller = MainTabBarController()
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
    }
    
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = emailTextField.text
        } else {
            viewModel.password = passwordTextField.text
        }
        
        checkFormStatus()
    }
    
    //MARK: - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemTeal
        }
    }
    
    func configureUI() {
        configureNavigationBar()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
        titleLabel.centerX(inView: view)
    
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 30
        
        view.addSubview(stack)
        stack.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 40, paddingLeft: 32, paddingRight: 32)
        stack.centerX(inView: view)

        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
        dontHaveAccountButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Successfully signed user out")
        } catch {
            print("DEBUG: Failed to sign out..")
        }
    }
    

}
