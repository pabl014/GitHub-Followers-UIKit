//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 14/02/2024.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // this is called when we initialize this GF button via storyboard (we are not doing it there, but it is required to implement)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // our own init
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero) // we will set the frame in auto layout constraints so we can initialize it with .zero frame
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false // required to use Auto Layout and do our constraints programatically
    }
    
    // function that allows to modify color and title of a button
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
