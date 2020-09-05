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
        let frame = CGRect(x: 0, y: 150, width: view.frame.width, height: view.frame.height)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .white
        cv.register(SpaceCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        return cv
    }()
    
    private var spaces = [SearchCardCell]() {
        didSet {
            collectionView.reloadData()
        }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .default
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
                
                var result = [SearchCardCell]()
                
                for business in businesses {
                    guard let name = business.value(forKey: "name") as? String else { return }
                    guard let id = business.value(forKey: "id") as? String else { return }
                    
                    let imageUrl = business.value(forKey: "image_url") as? String
                    guard let reviewCount = business.value(forKey: "review_count") as? Int else { return }
                    guard let rating = business.value(forKey: "rating") as? Double else { return }
                    
                    let space = SearchCardCell(id: id, name: name, imageUrl: imageUrl, rating: rating, reviewCount: reviewCount)
                    
                    result.append(space)
                }
                
                self.spaces = result
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchHeaderView)
        searchHeaderView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 106)
//        searchHeaderView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
        view.addSubview(collectionView)

    }
}

//MARK: - UICollectionViewDataSource

extension SearchResultsController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return spaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let space = spaces[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SpaceCell
        cell.space = SearchCardCell(id: space.id, name: space.name, imageUrl: space.imageUrl, rating: space.rating, reviewCount: space.reviewCount)
        return cell
    }
}

//MARK: - UICollectionViewDataSource

extension SearchResultsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let spaceID = spaces[indexPath.row].id else { return }
        let controller = SpaceShowController(spaceID: spaceID)
        navigationController?.pushViewController(controller, animated: true)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SearchResultsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.9, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
