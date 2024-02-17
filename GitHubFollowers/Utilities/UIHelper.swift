//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 17/02/2024.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        
        let width                   = view.bounds.width // full width of a view
        let padding: CGFloat        = 12
        let minimumSpacing: CGFloat = 10
        let availableWidth          = width - (padding * 2) - (minimumSpacing * 2) // available width after subtracting all spaces between three images in the row
        let itemWidth               = availableWidth / 3 // with for one image
        
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize         = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
