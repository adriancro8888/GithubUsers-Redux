//
//  SelectUser.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/28/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import Foundation

func selectUser(user: User, getURL: @escaping (URL) -> Future<UserDetail> = getURL) -> CommandWith<Dispatcher> {
    return CommandWith { dispatcher in
        dispatcher.dispatch(action: DidSelectUser(user: user))
        dispatcher.dispatch(future:
            getURL(URL(string:"https://api.github.com/users/\(user.userId)")!).map(transform: DidLoadUserDetail.init)
        )
    }
}
