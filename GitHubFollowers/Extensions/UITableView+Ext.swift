//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 11/03/2024.
//

import UIKit

extension UITableView {
    
    
    func reloadDataOnMainThread() { // useful func in extension
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
