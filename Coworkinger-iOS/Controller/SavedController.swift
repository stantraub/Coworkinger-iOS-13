//
//  SavedController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class SavedController: UITableViewController {
    
    //MARK: - Properties
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .magenta
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Helpers
}
