//
//  UserListState.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

struct UserListState {
    let users: [User]
    static let initial = UserListState(users: [])
}

func reduce(_ state: UserListState, with action: Action) -> UserListState {
    //ToDo
    return UserListState(users: [])
}
