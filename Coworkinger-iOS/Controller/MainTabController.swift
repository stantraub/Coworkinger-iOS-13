//
//  MainTabBarController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    var user: User?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
//        logout()
        checkIfUserIsLoggedIn()
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            presentLoginController()
        } else {
            fetchUser()
            configureViewControllers()
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Service.fetchUser(withUid: uid) { user in
            self.user = user
            self.configureViewControllers()
        }
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        guard let user = self.user else { return }
        
        let search = SearchController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(named: "search_unselected"), title: "Search", rootViewcontroller: search)
        
        let saved = SavedController()
        let nav2 = templateNavigationController(image: UIImage(named: "like_unselected"), title: "Saved", rootViewcontroller: saved)
        
        
        let profile = ProfileController(user: user)
        let nav3 = templateNavigationController(image: UIImage(named: "home_unselected"), title: "Profile", rootViewcontroller: profile)
        
        viewControllers = [nav1, nav2, nav3]
    }
    
    func presentLoginController() {
        DispatchQueue.main.async {
            let nav = UINavigationController(rootViewController: LoginController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func templateNavigationController(image: UIImage?, title: String, rootViewcontroller: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewcontroller)
        nav.tabBarItem.image = image
        nav.tabBarItem.title = title
        nav.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.systemBlue, .font: UIFont(name: "Avenir", size: 12) ?? UIFont.systemFont(ofSize: 12)], for: .normal)
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    func logout() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: Successfully signed user out")
        } catch {
            print("DEBUG: Failed to sign out..")
        }
    }
    
}
