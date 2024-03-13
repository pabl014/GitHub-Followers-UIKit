//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 07/03/2024.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemVCDelegate! // delegate variables need to be weak to prevent retain cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    init(user: User, delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // custom stuff
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoViewTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
