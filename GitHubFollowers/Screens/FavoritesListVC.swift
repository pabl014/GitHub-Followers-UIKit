//
//  FavoritesListVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 14/02/2024.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
                
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
    }
}
