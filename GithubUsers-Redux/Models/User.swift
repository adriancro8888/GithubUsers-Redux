//
//  User.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

struct User: Codable {
    let userName: String
    let userId: Int
    let userAvatar: String
    let userType: String
    
    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case userId = "id"
        case userAvatar = "avatar_url"
        case userType = "type"
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userName == rhs.userName
            && lhs.userId == rhs.userId
            && lhs.userAvatar == rhs.userAvatar
            && lhs.userType == rhs.userType
    }
}
