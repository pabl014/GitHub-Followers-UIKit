//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 10/03/2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
