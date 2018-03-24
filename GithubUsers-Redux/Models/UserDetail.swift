//
//  UserDetail.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation
struct UserDetail: Codable {
    private let _name: String?
    var name: String {
        return _name ?? "No Name"
    }
    private let _userLocation: String?
    var userLocation: String {
        return _userLocation ?? "N/A"
    }
    private let _company: String?
    var userCompany: String {
        return _company ?? "N/A"
    }
    let userImage: String
    private   let _userEmail: String?
    var userEmail: String {
        return _userEmail ?? "N/A"
    }
    private let _userBio: String?
    var userBio: String {
        return _userBio ?? "N/A"
    }
    let publicRepos: Int
    let publicGists: Int
    let userFollowers: Int
    let userFollowing: Int
    
    private enum CodingKeys: String, CodingKey {
        case _name = "name"
        case _userLocation = "location"
        case _company = "company"
        case userImage = "avatar_url"
        case _userEmail = "email"
        case _userBio = "bio"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case userFollowers = "followers"
        case userFollowing = "following"
    }
    
}
