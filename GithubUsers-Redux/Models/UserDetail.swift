//
//  UserDetail.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
struct UserDetail: Codable {
    let name: String?
    let location: String?
    let company: String?
    let image: String
    let email: String?
    let bio: String?
    let publicRepos: Int
    let publicGists: Int
    let userFollowers: Int
    let userFollowing: Int
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case location = "location"
        case company = "company"
        case image = "avatar_url"
        case email = "email"
        case bio = "bio"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case userFollowers = "followers"
        case userFollowing = "following"
    }
    
}
