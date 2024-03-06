//
//  GFSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 05/03/2024.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor                 = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail
        
        translatesAutoresizingMaskIntoConstraints = false
    }

}