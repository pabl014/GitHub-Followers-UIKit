//
//  GFUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 05/03/2024.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let usernameLabel       = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = GFBodyLabel(textAlignment: .left)
    
    var user: User!
    
    //init with user so we can assign all user stuff to UI components
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()

    }
    
    func addSubviews() {
        // we can also add stuff from lines 12 - 17 to an array and then use here "for" loop
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)

    }
    
    func layoutUI() {
        let padding: CGFloat            = 20 // left and right side of the screen
        let textImagePadding: CGFloat   = 12 // for labels to the right of the avatar image
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // place constraints here
        ])
    }
}
