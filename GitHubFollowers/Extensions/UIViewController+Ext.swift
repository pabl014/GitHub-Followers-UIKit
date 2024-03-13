//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 15/02/2024.
//

import UIKit
import SafariServices

// fileprivate var containerView: UIView! // fileprivate: anything in this file can use this variable

extension UIViewController {
    
    // var containerView: UIView! -> you cannot create variables in extensions !!!
    
    func presentGFAlert(title: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        present(alertVC, animated: true)
    }
    
    // if some different error happens
    // catch-all generic error, when we don't have anything specific thing to tell the user
    func presentDefaultError() {
        let alertVC = GFAlertVC(title: "Something went wrong",
                                message: "We were unable to complete your task at this time. Please try again.",
                                buttonTitle: "Ok")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle   = .crossDissolve
        self.present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        
        present(safariVC, animated: true)
    }
    
}
