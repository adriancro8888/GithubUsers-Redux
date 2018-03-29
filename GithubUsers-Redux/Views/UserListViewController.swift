//
//  ViewController.swift
//  GithubUsers-Redux
//
//  Created by Shabir Jan on 3/24/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    struct Props {
        let users : [User]
        
        struct User {
            let name: String
            
            let select: CommandWith<UIViewController>
        }
        static let initial = Props(users: [])
    }
    
    var props: Props = .initial {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else {
            fatalError("Cannot start transition from sender: \(String(describing: sender))")
        }
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            fatalError("Cannot get index path from cell: \(cell)")
        }
        guard props.users.indices.contains(indexPath.row) else {
            fatalError("Index path \(indexPath) is out of bounds")
        }
        
        props.users[indexPath.row].select.perform(with: segue.destination)
        
        
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // It is nice sanity check to catch some issues early.
        guard props.users.indices.contains(indexPath.row) else {
            fatalError("Index: \(indexPath) is out of bounds")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") else {
            fatalError("Cannot get cell for single user")
        }
        
        cell.textLabel?.text = props.users[indexPath.row].name
        
        return cell
    }
}

extension UserListViewController {
    func connect(to store: Store<AppState>) {
        func userProps(from user: User) -> Props.User {
            let select = CommandWith<UIViewController> { vc in
                guard let userDetails = vc as? UserDetailViewController else {
                    fatalError("Cannot handle selected vc: \(vc)")
                }
                vc.title = user.userName
                
                store.dispatch(command: selectUser(user: user))
                /// Connecting controller to store.
                userDetails.connect(to: store)
                
            }
            return Props.User(name: user.userName, select: select)
        }
        
        let observer = CommandWith<AppState>(id: "List vc observer for \(self)") { state in
            let users: [Props.User] = state.userList.users.map(userProps)
            self.props = Props(users: users)
        }
        store.observe(with: observer.dispatched(on: .main))
    }
}
