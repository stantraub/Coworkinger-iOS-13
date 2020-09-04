//
//  ExploreController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/21/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class DiscoverController: UITableViewController {
    
    //MARK: - Properties
    var query = ""
    private lazy var searchBoxView = DiscoverSearchView()

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.isHidden = true
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
    }
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        tableView.tableHeaderView = searchBoxView
        searchBoxView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 250)
        searchBoxView.delegate = self
    }
}

extension DiscoverController: DiscoverSearchViewDelegate {
    func handleSearchButtonTapped(withQuery query: String) {
        let controller = SearchResultsController(query: query)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
