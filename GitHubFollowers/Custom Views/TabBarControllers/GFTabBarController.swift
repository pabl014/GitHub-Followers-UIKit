//
//  GFTabBarController.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 09/03/2024.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen // UITabBar.appearance(), because we want to affect ALL of our UITabBars. appearance() -> global configuration for that element
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    // creating Serach Navigation  Controller
    func createSearchNC() -> UINavigationController {
        let searchVC        = SearchVC()
        searchVC.title      = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0) // tag is used to identify the object
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    // creating Favorites Navigation  Controller
    func createFavoritesNC() -> UINavigationController {
        let favoritesListVC        = FavoritesListVC()
        favoritesListVC.title      = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoritesListVC)
    }
    
}
