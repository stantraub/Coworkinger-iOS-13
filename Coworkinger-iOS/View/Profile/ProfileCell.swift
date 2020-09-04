//
//  SettingsCell.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/19/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    //MARK: - Properties
    
    var viewModel: ProfileViewModel! {
        didSet { configure() }
    }
    
    lazy var inputField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.systemFont(ofSize: 16)
        
        let paddingView = UIView()
        paddingView.setDimensions(height: 50, width: 28)
        
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(inputField)
        inputField.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configure() {
        inputField.placeholder = viewModel.placeholderText
        inputField.text = viewModel.value
    }
    
}
