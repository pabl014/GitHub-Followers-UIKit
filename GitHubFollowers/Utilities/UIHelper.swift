//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 17/02/2024.
//

import UIKit

// If this was a struct instead of an enum, we can do let help = UIHelper(), so we initialized an empty UIHelper.
// We don't want to do it, so with enum we can't init an empty one, we will use UIHelper.create... .

enum UIHelper {
    
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
