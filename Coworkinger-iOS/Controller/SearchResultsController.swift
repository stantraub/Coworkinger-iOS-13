//
//  ExploreController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/17/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "SearchCell"

class SearchResultsController: UIViewController {
    
    //MARK: - Properties
    
    var query: String
    lazy var searchHeaderView = SearchResultsHeaderView(query: query)
    
    private lazy var collectionView: UICollectionView = {
//        let frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(SpaceCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    private var spaces = [SpaceSearchCell]() {
        didSet { collectionView.reloadData() }
    }
    
    //MARK: - Lifecycle
    
    init(query: String) {
        self.query = query

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSpaces(withQuery: query)
        configureUI()
    }
    
    //MARK: - Selectors
    
    func fetchSpaces(withQuery query: String) {
        let headers: HTTPHeaders = [
            "Authorization": "Bearer zviqn8ofmwNsQdc578yv18QisgZ__djepMcpt7mEldkAn6XFo1AtNO3KwLnGBRw_GVwOD_ti_S7vuowhnohSek8Qh7djrC5YHYYcYMwDfL8Ng9GRqmfXjELvksgwX3Yx"
        ]
        
        AF.request("https://api.yelp.com/v3/businesses/search?categories=sharedofficespaces&term=shared_office_spaces&location=\(query)", headers: headers).responseJSON { (response) in
            switch response.result {
            case let .success(value):
                guard let resp = value as? NSDictionary else { return }
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return }
                
                for business in businesses {
                    guard let name = business.value(forKey: "name") as? String else { return }
                    guard let id = business.value(forKey: "id") as? String else { return }
                    
                    let space = SpaceSearchCell(id: id, name: name)
                    
                    self.spaces.append(space)
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchHeaderView)
        searchHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 100)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: searchHeaderView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20)
//        searchHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    }
}

//MARK: - UICollectionViewDataSource

extension SearchResultsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let space = spaces[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SpaceCell
        cell.space = SpaceSearchCell(id: space.id, name: space.name)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let spaceID = spaces[indexPath.row].id else { return }
//        let controller = SpaceShowController(spaceID: spaceID)
//        navigationController?.pushViewController(controller, animated: true)
//    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SearchResultsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
