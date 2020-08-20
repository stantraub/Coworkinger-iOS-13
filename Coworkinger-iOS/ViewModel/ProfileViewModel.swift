//
//  SettingsSections.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/19/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import Foundation

enum ProfileSections: Int, CaseIterable {
    case name
    case username
    case email
    
    var description: String {
        switch self {
            case .name: return "Full Name"
            case .username: return "Username"
            case .email: return "Email"
        }
    }
}

struct ProfileViewModel {
    
    private let user: User
    
    let section: ProfileSections
    let placeholderText: String
    let value: String?

    init(user: User, section: ProfileSections) {
        self.user = user
        self.section = section
        
        placeholderText = "Enter \(section.description.lowercased()).."
        
        switch section {
            case .name:
                value = user.fullname
            case .username:
                value = user.username
            case .email:
                value = user.email
        }

    }
    
    
}
