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
    
    private enum CodingKeys: String, CodingKey {
        case userName = "login"
        case userId = "id"
    }
}

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userName == rhs.userName
            && lhs.userId == rhs.userId
    }
}
