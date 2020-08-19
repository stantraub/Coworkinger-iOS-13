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
    
    var space: Space? {
        didSet { configureSpace() }
    }
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .red
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        
    }
    
    func configureSpace() {
        guard let space = space else { return }
        print(space)
    }
    
    
    
    
}
