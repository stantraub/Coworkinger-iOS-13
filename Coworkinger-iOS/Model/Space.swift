//
//  Space.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import Foundation

struct SpaceCoordinates: Codable {
    let latitude: Float
    let longitiude: Float
}

struct SpaceHours: Codable {
    
}

struct SpaceLocation: Codable {
    let address: String
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let coordinates: SpaceCoordinates
}

struct Space: Codable {
    let id: String
    let name: String
    let imageUrl: String
    let isClosed: String
    let displayPhone: String
    let reviewCount: Int
    let rating: Double
    let location: SpaceLocation
    let photos: [String]
    let hours: SpaceHours
}
