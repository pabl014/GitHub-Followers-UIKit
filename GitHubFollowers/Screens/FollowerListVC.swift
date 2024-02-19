//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 14/02/2024.
//

import UIKit

class FollowerListVC: UIViewController {
    
    enum Section {
        case main // main section of our collectionView
    }
    
    var username: String!
    var followers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! // it has to know about our section and our items in section

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func getFollowers() {
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in // [weak self] -> capture list
            
            guard let self = self else { return }
            
            switch result {
                case .success(let followers):
                    self.followers = followers
                    self.updateData()

                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Bad stuff happened", message: error.rawValue, buttonTitle: "Ok")
            }
            
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell // creating a cell
            cell.set(follower: follower) // cell configuration: for every follower, sending info into the FollowerCell and func set(follower: Follower) is going to set the username text of the cell to the follower.login and avatar to the follower.avatarUrl
            return cell
        })
    }
    
    // 5:06:35 https://www.youtube.com/watch?v=JzngncpZLuw&t=201s
    // 1. It takes the snapshot of what current data is
    // 2. Takes the snapshot of the new data
    // 3. Apply changes with cool animation between old and new snapshots
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>() // create snapshot
        snapshot.appendSections([.main]) // add to snapshot
        snapshot.appendItems(followers) // add to snapshot
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true) // apply to the snapshot
        }
    }
}
