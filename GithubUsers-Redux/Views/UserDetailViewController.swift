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
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewWillLayoutSubviews() {
        title = props.name
        
        
        loadingIndicator.isHidden = result {
            guard case .user = props.state else { return false }
            return true
        }
        lblPublicGist.isHidden = !loadingIndicator.isHidden
        lblPublicRepos.isHidden = !loadingIndicator.isHidden
        
        
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
            case .loaded(let userDetail): self?.props = Props(name: userDetail.name!, onDestroy: cancelObserving, state: .user(Props.User(name: userDetail.name!, publicRepos: userDetail.publicRepos, publicGists: userDetail.publicGists)))
            }
            
        }
         cancelObserving = store.observe(with: observer.dispatched(on: .main))
    }
}
