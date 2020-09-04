//
//  SearchResultsHeaderView.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 9/3/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class SearchResultsHeaderView: UIView {
    //MARK: - Properties
    
    var query: String
    
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
        tf.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return tf
    }()
    
    //MARK: - Lifecycle
    
    init(query: String) {
        self.query = query
        super.init(frame: .zero)
        
        searchField.text = self.query
        addSubview(searchFieldContainer)
        searchFieldContainer.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    //MARK: - Selectors
    
    @objc func textDidChange() {
        print("sup")
    }
    
    
}
