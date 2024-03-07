//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 07/03/2024.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // custom stuff
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
