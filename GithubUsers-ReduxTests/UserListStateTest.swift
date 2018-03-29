//
//  UserListStateTest.swift
//  GithubUsers-ReduxTests
//
//  Created by Shabir Jan on 3/29/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import XCTest
@testable import GithubUsers_Redux
class UserListStateTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func test(){
        var userListState = UserListState(users: [.init(userName: "Shabir", userId: 1),.init(userName: "Max", userId: 2)])
        let action = DidLoadUsers(users: [.init(userName: "Alex", userId: 3), .init(userName: "Ross", userId: 4)])
        
        userListState = reduce(userListState, with: action)
        
        XCTAssert(userListState.users == [.init(userName: "Shabir", userId: 1),.init(userName: "Max", userId: 2),.init(userName: "Alex", userId: 3), .init(userName: "Ross", userId: 4)])
    }
}
