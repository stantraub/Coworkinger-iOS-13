//
//  ExploreController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "reuseIdentifier"

class SearchController: UICollectionViewController {
    
    //MARK: - Properties
    
    private let spaces = [Space]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBlue
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        fetchSpaces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Selectors
    
    func fetchSpaces() {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer zviqn8ofmwNsQdc578yv18QisgZ__djepMcpt7mEldkAn6XFo1AtNO3KwLnGBRw_GVwOD_ti_S7vuowhnohSek8Qh7djrC5YHYYcYMwDfL8Ng9GRqmfXjELvksgwX3Yx"
        ]
        
        AF.request("https://api.yelp.com/v3/businesses/bespoke-coworking-san-francisco-6", headers: headers).responseJSON { response in
            print(response)
        }
    }
    
    //MARK: - Helpers
    

    

}

//MARK: - UICollectionViewDelegate/DataSource

extension SearchController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as UICollectionViewCell
        return cell
    }
}
