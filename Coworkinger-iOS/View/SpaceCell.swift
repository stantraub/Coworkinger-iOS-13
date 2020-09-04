//
//  SpaceCell.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/18/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class SpaceCell: UICollectionViewCell {
    //MARK: - Properties
    
    var space: SpaceSearchCell? {
        didSet { configureSpace() }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - API
    
    //MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .systemBlue
        addSubview(titleLabel)
        titleLabel.anchor(left: leftAnchor, paddingLeft: 10)
        titleLabel.centerY(inView: self)
    }
    
    func configureSpace() {
        guard let space = space else { return }
        titleLabel.text = space.name
    }
    
    
    
    
}
