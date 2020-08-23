//
//  SpaceShowController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/20/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit
import Alamofire

class SpaceShowController: UIViewController {
    
    //MARK: - Properties
    
    var spaceID: String
    var space: Space? {
        didSet { print(space!) }
    }
//    lazy var mainPhotoView = SpacePicture(photo: space?.imageUrl ?? "")
//    lazy var informationView = SpaceInformation(space: space!)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//
//        view.addSubview(mainPhotoView)
//        mainPhotoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 275)
//        mainPhotoView.delegate = self
//
//        view.addSubview(informationView)
//        informationView.anchor(top: mainPhotoView.bottomAnchor, left: view.leftAnchor,
//                               paddingTop: 15, paddingLeft: 20,
//                               width: view.frame.width - 40, height: 150)
        
    }

}

extension SpaceShowController: SpacePictureDelegate {
    func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
