//
//  UserDetailViewController.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/28/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    struct Props {
        let name: String
        let onDestroy: Command?
        let state: State
        
        enum State {
            case loading
            case user(User)
        }
        struct  User {
            let name: String
            let userEmail: String
            let userCompany: String
            let userLocation: String
            let userFollowers:Int
            let userFollowing:Int
            let publicRepos: Int
            let publicGists: Int
        }
        static let initial = Props(name: "", onDestroy: nil, state: .loading)
    }
    
    var props: Props = .initial {
        didSet {
            guard isViewLoaded else { return }
            
            view.setNeedsLayout()
        }
    }
    
    
    @IBOutlet weak var lblPublicRepos: UILabel!
    @IBOutlet weak var lblPublicGist: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserCompany: UILabel!
    @IBOutlet weak var lblUserLocation: UILabel!
    @IBOutlet weak var lblUserFollowers: UILabel!
    @IBOutlet weak var lblUserFollowing: UILabel!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewWillLayoutSubviews() {
        title = props.name
        
        
        loadingIndicator.isHidden = result {
            guard case .user = props.state else { return false }
            return true
        }
        lblPublicGist.isHidden = !loadingIndicator.isHidden
        lblPublicRepos.isHidden = !loadingIndicator.isHidden
        lblUserName.isHidden = !loadingIndicator.isHidden
        lblUserEmail.isHidden = !loadingIndicator.isHidden
        lblUserCompany.isHidden = !loadingIndicator.isHidden
        lblUserLocation.isHidden = !loadingIndicator.isHidden
        lblUserFollowers.isHidden = !loadingIndicator.isHidden
        lblUserFollowing.isHidden = !loadingIndicator.isHidden
        
        lblUserName.text = result {
            guard case .user(let user) = props.state else { return "N/A" }
            return user.name
        }
        lblUserEmail.text = result {
            guard case .user(let user) = props.state else { return "N/A" }
            return user.userEmail
        }
        lblUserCompany.text = result {
            guard case .user(let user) = props.state else { return "N/A" }
            return user.userCompany
        }
        lblUserLocation.text = result {
            guard case .user(let user) = props.state else { return "N/A" }
            return user.userLocation
        }
        lblUserFollowers.text = result {
            guard case .user(let user) = props.state else { return "N/A" }
            return String(user.userFollowers)
        }
        lblUserFollowing.text = result {
            guard case .user(let user) = props.state else { return "N/A" }
            return String(user.userFollowing)
        }
        lblPublicRepos.text = result {
            guard case .user(let user) = props.state else { return "" }
            return String(user.publicRepos)
        }
        
        lblPublicGist.text = result {
            guard case .user(let user) = props.state else { return "" }
            return String(user.publicGists)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        props.onDestroy?.perform()
    }

}

extension UserDetailViewController {
    func connect(to store:Store<AppState>) {
        var cancelObserving: Command?
        
        let observer = CommandWith<AppState>(id: "User Details observer for \(self)") { [weak self] state in
            switch state.selectedUser {
            case .none: self?.props = Props.initial
            case .loading(let user): self?.props = Props(name: user.userName, onDestroy: cancelObserving, state: .loading)
            case .loaded(let userDetail): self?.props = Props(name: userDetail.name ?? "N/A" , onDestroy: cancelObserving, state: .user(Props.User(name: userDetail.name ?? "N/A", userEmail: userDetail.email ?? "N/A", userCompany: userDetail.company ?? "N/A", userLocation: userDetail.location ?? "N/A", userFollowers: userDetail.userFollowers, userFollowing: userDetail.userFollowing, publicRepos: userDetail.publicRepos, publicGists: userDetail.publicGists)))
            }
            
        }
         cancelObserving = store.observe(with: observer.dispatched(on: .main))
    }
}
