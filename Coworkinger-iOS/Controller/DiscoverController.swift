//
//  ExploreController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/21/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class DiscoverController: UIViewController {
    
    //MARK: - Properties
    
    private let searchBoxView = DiscoverSearchView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.isHidden = true
        configureUI()
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        view.addSubview(searchBoxView)
        searchBoxView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 2)
        searchBoxView.delegate = self
    }
}

extension DiscoverController: DiscoverSearchViewDelegate {
    func handleSearchButtonTapped() {
        let controller = SearchController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
