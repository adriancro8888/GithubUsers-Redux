//
//  LoadUsers.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/28/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

func loadUsers(url: URL, getURL: @escaping (URL) -> Future<[User]> = getURL) -> Future<Action> {
    return getURL(url).map(transform: DidLoadUsers.init)
}

