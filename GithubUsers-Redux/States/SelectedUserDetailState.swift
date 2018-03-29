//
//  UserDetailState.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

enum SelectedUserDetailState {
    case none
    case loading(User)
    case loaded(UserDetail)
    
    static let initial = SelectedUserDetailState.none
}

func reduce(_ state: SelectedUserDetailState, with action: Action) -> SelectedUserDetailState {
    switch action {
    case let action as DidSelectUser: return .loading(action.user)
    case let action as DidLoadUserDetail: return .loaded(action.userDetail)
    default: return state
    }
}

