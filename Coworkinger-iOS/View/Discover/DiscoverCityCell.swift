//
//  File.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 9/2/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class DiscoverCityCell: UITableViewCell {
    
    var city: String? {
        didSet {
            configureCell()
        }
    }
//    let image: UIImage
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        guard let city = city else { return }
        print(city)
        print("hi")
    }
}
