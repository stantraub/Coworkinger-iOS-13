//
//  SpaceShowController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/20/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "SpaceShowPictureCell"

class SpaceShowController: UIViewController {
    
    //MARK: - Properties
    
    var spaceID: String
    var space: Space? {
        didSet {
            viewModel = SpaceShowViewModel(space: space!)
            informationView = SpaceInformation(space: space!)
            
            view.addSubview(informationView!)
            informationView?.anchor(top: collectionView.bottomAnchor, left: view.leftAnchor,
                                   paddingTop: 15, paddingLeft: 20, paddingRight: 20,
                                   width: view.frame.width, height: 150)
            
            collectionView.reloadData()
        }
    }
    
    var viewModel: SpaceShowViewModel?
    var informationView: SpaceInformation?
    
    private let gradientLayer = CAGradientLayer()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        return button
    }()

    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal).withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: -25, width: view.frame.width, height: 350)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: frame, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.register(SpaceShowPhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.frame = frame
        cv.layer.addSublayer(gradientLayer)
        
        return cv
    }()
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        fetchSpace(withID: spaceID)
        configureUI()
    }

    
    init(spaceID: String) {
        self.spaceID = spaceID
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleBackButtonTapped() {
        
    }
    
    @objc func handleLikeTapped() {
        
    }
    
    //MARK: - API
    
    func fetchSpace(withID id: String) {
         let headers: HTTPHeaders = [
            "Authorization": "Bearer zviqn8ofmwNsQdc578yv18QisgZ__djepMcpt7mEldkAn6XFo1AtNO3KwLnGBRw_GVwOD_ti_S7vuowhnohSek8Qh7djrC5YHYYcYMwDfL8Ng9GRqmfXjELvksgwX3Yx"
            ]
               
           AF.request("https://api.yelp.com/v3/businesses/\(spaceID)", headers: headers).responseJSON { (response) in
               switch response.result {
               case let .success(value):
                    guard let resp = value as? NSDictionary else { return }
                    
                    guard let id = resp.value(forKey: "id") as? String else { return }
//                    guard let phone = resp.value(forKey: "display_phone") as? String else { return }
//                    guard let address = resp.value(forKeyPath: "location.display_address") as? String else { return }
                    guard let name = resp.value(forKey: "name") as? String else { return }
                    guard let photos = resp.value(forKey: "photos") as? [String] else { return }
                    guard let rating = resp.value(forKey: "rating") as? Double else { return }
                    guard let reviewCount = resp.value(forKey: "review_count") as? Int else { return }
                
                    self.space = Space(id: id, name: name, reviewCount: reviewCount, rating: rating, photos: photos)
                    

               case let .failure(error):
                   print(error)
               }
           }
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(collectionView)
    }

}

//MARK: - UICollectionViewDelegate

extension SpaceShowController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageURLs.count ?? 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SpaceShowPhotoCell
        cell.imageView.sd_setImage(with: viewModel?.imageURLs[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDataSource

extension SpaceShowController: UICollectionViewDataSource {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SpaceShowController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
