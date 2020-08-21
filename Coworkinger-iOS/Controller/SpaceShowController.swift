//
//  SpaceShowController.swift
//  Coworkinger-iOS
//
//  Created by Stanley Traub on 8/20/20.
//  Copyright © 2020 Stanley Traub. All rights reserved.
//

import UIKit

class SpaceShowController: UIViewController {
    
    //MARK: - Properties
    
    var space: Space?
    lazy var mainPhotoView = SpacePicture(photo: space?.imageUrl ?? "")
    lazy var informationView = SpaceInformation(space: space!)
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }

    
    init(space: Space) {
        self.space = space
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(mainPhotoView)
        mainPhotoView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 275)
        mainPhotoView.delegate = self
        
        view.addSubview(informationView)
        informationView.anchor(top: mainPhotoView.bottomAnchor, left: view.leftAnchor,
                               paddingTop: 15, paddingLeft: 20,
                               width: view.frame.width - 40, height: 150)
        
    }

}

extension SpaceShowController: SpacePictureDelegate {
    func handleBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
