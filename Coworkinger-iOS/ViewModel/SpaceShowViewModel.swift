//
//  SpaceShowViewModel.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/23/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import Foundation

struct SpaceShowViewModel {
    private let space: Space
    
    var imageURLs: [URL] {
        return space.photos.map({ URL(string: $0)!})
    }
    
    init(space: Space) {
        self.space = space
    }
}
