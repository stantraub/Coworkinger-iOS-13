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

class SearchController: UITableViewController {
    
    //MARK: - Properties
    
    private var spaces = [Space]() {
        didSet { tableView.reloadData() }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureSearchController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        fetchSpaces()
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
        
        AF.request("https://api.yelp.com/v3/businesses/search?categories=sharedofficespaces&term=\(query)&location=san_francisco", headers: headers).responseJSON { (response) in
            switch response.result {
            case let .success(value):
                guard let resp = value as? NSDictionary else { return }
                guard let businesses = resp.value(forKey: "businesses") as? [NSDictionary] else { return }
                
                for business in businesses {
                    guard let name = business.value(forKey: "name") as? String else { return }
                    guard let id = business.value(forKey: "id") as? String else { return }
                    guard let reviewCount = business.value(forKey: "review_count") as? Int else { return }
                    guard let rating = business.value(forKey: "rating") as? Double else { return }
                    guard let imageUrl = business.value(forKey: "image_url") as? String else { return }
                    
                    let address = business.value(forKeyPath: "location.address1") as? String
                    let city = business.value(forKeyPath: "location.city") as? String
                    let zipCode = business.value(forKeyPath: "location.zip_code") as? String
                    let country = business.value(forKeyPath: "location.country") as? String
                    let state = business.value(forKeyPath: "location.state") as? String
                    let location = SpaceLocation(address: address, city: city, zipCode: zipCode, country: country, state: state)
                    
                    let space = Space(id: id, name: name, imageUrl: imageUrl, reviewCount: reviewCount, rating: rating, location: location)
                    
                    self.spaces.append(space)
                    
                }
            case let .failure(error):
                print(error)
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        tableView.backgroundColor = .white
        tableView.register(SpaceCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    func configureSearchController() {
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a workspace.."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

//MARK: - UITableViewDelegate/DataSource

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spaces.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SpaceCell
        cell.space = spaces[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = SpaceShowController(space: spaces[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension SearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        spaces = []
        fetchSpaces(withQuery: searchText)
    }
    
    
    
}
