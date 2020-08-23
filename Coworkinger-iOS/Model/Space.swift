//
//  Space.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import Foundation

struct SpaceCoordinates {
    var latitude: Float
    var longitiude: Float
}

struct SpaceHours {
    
}

struct SpaceLocation {
    var address: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
//    var coordinates?: SpaceCoordinates
}

struct Space {
    var id: String?
    var name: String?
//    var isClosed: String?
//    var displayPhone: String?
    var reviewCount: Int?
    var rating: Double?
//    var location: SpaceLocation
    var photos: [String]
//    var hours: SpaceHours
}

struct SpaceSearchCell {
    var id: String?
    var name: String?
    //    var imageUrl: String?
}
