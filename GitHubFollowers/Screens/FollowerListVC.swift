//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 14/02/2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListVC: GFDataLoadingVC {
    
    enum Section {
        case main // main section of our collectionView
    }
    
    var username: String!
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>! // it has to know about our section and our items in section
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title         = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.delegate                   = self
        searchController.searchBar.placeholder                = "Search for a username"
        //searchController.obscuresBackgroundDuringPresentation = false // can't see any difference in iOS17
        navigationItem.searchController                       = searchController // in navigationItem search controller is built in
        navigationItem.hidesSearchBarWhenScrolling            = false
    }
    
    func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in // [weak self] -> capture list

            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
                case .success(let followers):
                    if followers.count < 100 { self.hasMoreFollowers = false }
                    self.followers.append(contentsOf: followers)
                
                    if self.followers.isEmpty {
                        let message = "This user doesn't have any followers."
                        DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                        return
                    }
                
                self.updateData(on: self.followers)
                    
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
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>() // create snapshot
        snapshot.appendSections([.main]) // add to snapshot
        snapshot.appendItems(followers) // add to snapshot
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true) // apply to the snapshot
        }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in // getting whole user info to get avatarUrl to display it in FavoritesListVC
            
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
                case .success(let user):
                    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                    PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                        guard let self = self else { return }
                        
                        guard let error else {  
                            // what happens if we don't have an error:
                            self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user!", buttonTitle: "Ok")
                            return
                        }
                        
                        // if we have an error:
                        self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                    }
                    
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
            
            
        }
    }
}

extension FollowerListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY         = scrollView.contentOffset.y    // how far you scrolled
        let contentHeight   = scrollView.contentSize.height // the entire scrollView
        let height          = scrollView.frame.size.height  // height of an iPhone screen
        
//        print("OffsetY = \(offsetY)")
//        print("contentHeight = \(contentHeight)")
//        print("height = \(height)")
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray   = isSearching ? filteredFollowers : followers
        let follower      = activeArray[indexPath.item]
        //let follower = (isSearching ? filteredFollowers : followers)[indexPath.item] -> even faster way
        let destVC        = UserInfoVC()
        destVC.username   = follower.login
        destVC.delegate   = self // now FollowerListVC listens to UserInfoVC
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

// every time I change search reults in the search bar it is triggered
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    // filter the array and update collection view
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { // let filter be the text in the searchBar, check if it isn't empty
            isSearching = false // .
            updateData(on: followers)
            return
        }
        
        isSearching = true
        
        filteredFollowers = followers.filter {
            $0.login.lowercased()
                .contains(filter.lowercased())
        }
        
        updateData(on: filteredFollowers)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
    
    
}

extension FollowerListVC: FollowerListVCDelegate {
    
    func didRequestFollowers(for username: String) {
        // get followers for that user
        
        // reseting the screen:
        self.username   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true) // scroll the collection view up to the top
        
        getFollowers(username: username, page: page)
    }
}
