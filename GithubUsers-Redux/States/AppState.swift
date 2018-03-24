//
//  AppState.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

struct AppState {
    let userList: UserListState
    let selectedUser: UserDetailState
    static let initial = AppState(userList: UserListState.initial, selectedUser: UserDetailState.initial)
}

/// Reduce for composit states is trivial
func reduce(_ state: AppState, with action: Action) -> AppState {
    return AppState(
        userList: reduce(state.userList, with: action),
        selectedUser: reduce(state.selectedUser, with: action))
}
