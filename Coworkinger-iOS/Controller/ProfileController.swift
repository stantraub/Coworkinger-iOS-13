//
//  ProfileController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

private let reuseIdentifier = "reuseIdentifier"

class ProfileController: UITableViewController {
    
    //MARK: - Properties
    
    var user: User
    
    private lazy var headerView = ProfileHeader(user: user)
    private let footerView = ProfileFooter()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    init(user: User) {
        self.user = user
        super.init(style: .plain)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureTableView() {
        tableView.tableHeaderView = headerView
        tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.backgroundColor = .systemGroupedBackground
        tableView.rowHeight = 44
//        tableView.separatorStyle = .none
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 120)
        
        tableView.tableFooterView = footerView
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 88)
        footerView.delegate = self
    }
    
    func presentLoginController() {
        DispatchQueue.main.async {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
}

//MARK: - UITableViewDataSource

extension ProfileController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileSections.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
        guard let section = ProfileSections(rawValue: indexPath.section) else { return cell}
        let viewModel = ProfileViewModel(user: user, section: section)
        cell.viewModel = viewModel
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ProfileController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = ProfileSections(rawValue: section) else { return nil}
        return section.description
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ProfileController: ProfileFooterDelegate {
    func handleLogout() {
        do {
            try Auth.auth().signOut()
            presentLoginController()
        } catch {
            print("Error signing out with \(error.localizedDescription)")
        }
    }
    
    
}
