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
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero) // we will set the frame in auto layout constraints so we can initialize it with .zero frame
        set(color: color, title: title, systemImageName: systemImageName)
    }
    
    private func configure() {
        
        configuration              = .filled()

        //layer.cornerRadius      = 10
        configuration?.cornerStyle = .medium
        //titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        //setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false // required to use Auto Layout and do our constraints programatically
    }
    
    // function that allows to modify color and title of a button
    func set(color: UIColor, title: String, systemImageName: String) {
        
        configuration?.baseBackgroundColor  = color
        configuration?.baseForegroundColor  = .white
        configuration?.title                = title
//        self.backgroundColor = backgroundColor
//        setTitle(title, for: .normal)
        configuration?.image                = UIImage(systemName: systemImageName)
        configuration?.imagePadding         = 6
        configuration?.imagePlacement       = .leading
    }
}

#Preview {
    GFButton(color: .blue,
             title: "Test button",
             systemImageName: "pencil")
}
