//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 14/02/2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        
        let width                   = view.bounds.width // full width of a view
        let padding: CGFloat        = 12
        let minimumSpacing: CGFloat = 10
        let availableWidth          = width - (padding * 2) - (minimumSpacing * 2) // available width after subtracting all spaces between three images in the row
        let itemWidth               = availableWidth / 3 // with for one image
        
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize         = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
    
    func getFollowers() {
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            switch result {
                
                case .success(let followers):
                    print("Followers.count = \(followers.count)")
                    print(followers)

                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
}
