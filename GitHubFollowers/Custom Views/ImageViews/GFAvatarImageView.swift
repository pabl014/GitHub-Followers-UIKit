//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 16/02/2024.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache            = NetworkManager.shared.cache
    
    let placeholderImage = UIImage(named: "avatar-placeholder")
    
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
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    // we are not handling any errors here (our error is a placeholderImage instead of an avatar, so it's ok to place networking stuff here, it's not necessary to place that code in NetWorkManager.swift
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return } // not handling an error, because our "handling" is displaying a placeholder
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            // if we finally hae an image:
            self.cache.setObject(image, forKey: cacheKey) // send it to the cache
            
            DispatchQueue.main.async {
                self.image = image  // going to the main thread and setting image to the image we downloaded
            }
        }
        
        task.resume()
    }
}
