//
//  AppDelegate.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
       
        
        let store = Store(state: AppState.initial, reducer: reduce)
        let navigation = window?.rootViewController as! UINavigationController
        let vc = navigation.viewControllers.first as! UserListViewController
        /// Connect initial controller to application store.
        vc.connect(to: store)
        let url = URL(string: "https://api.github.com/users")!
        store.dispatch(future: loadUsers(url: url))
        return true
    }
    
}

