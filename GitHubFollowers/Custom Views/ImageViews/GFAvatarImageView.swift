//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 16/02/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = Images.placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from url: String) {
//        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
//            guard let self = self else { return }
//            
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }
        
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? Images.placeholderImage
        }
    }
    
}
