//
//  ExploreSearchView.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/21/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

protocol DiscoverSearchViewDelegate: class {
    func handleSearchButtonTapped()
}

class DiscoverSearchView: UIView {
    
    //MARK: - Properties
    
    weak var delegate: DiscoverSearchViewDelegate?
    
    var searchText = ""
    
    private let searchTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Where do you want to work?"
        label.font = UIFont(name: "Avenir-Heavy", size: 23)
        return label
    }()
    
    private lazy var searchFieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3
        
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        
        view.addSubview(iv)
        iv.anchor(left: view.leftAnchor, paddingLeft: 8)
        iv.centerY(inView: view)

        view.addSubview(searchField)
        searchField.anchor(left: iv.rightAnchor, paddingLeft: 8)
        searchField.centerY(inView: view)
        
        return view
    }()
    
    private let searchField: UITextField = {
        let tf = UITextField()
        let placeholder = NSAttributedString(string: "Enter a city to work at", attributes: [.foregroundColor: UIColor.lightGray,
                                                                      .font: UIFont(name: "Avenir", size: 16) ?? UIFont.systemFont(ofSize: 16)])
        tf.attributedPlaceholder = placeholder
        return tf
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        let title = NSAttributedString(string: "Search", attributes: [.foregroundColor: UIColor.white,
                                                                      .font: UIFont(name: "Avenir-Heavy", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)])
        button.setAttributedTitle(title, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleSearchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .systemGroupedBackground
        
        let stack = UIStackView(arrangedSubviews: [searchTitleLabel, searchFieldContainer, searchButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 50, paddingLeft: 20, paddingRight: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleSearchButtonTapped() {
        delegate?.handleSearchButtonTapped()
    }
    
    //MARK: - Helpers
}
