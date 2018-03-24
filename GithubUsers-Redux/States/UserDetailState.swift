//
//  UserDetailState.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

enum UserDetailState {
    case none
    case loading(User)
    case loaded(UserDetail)
    
    static let initial = UserDetailState.none
}

func reduce(_ state: UserDetailState, with action: Action) -> UserDetailState {
    switch action {
    default: return state
    }
}

