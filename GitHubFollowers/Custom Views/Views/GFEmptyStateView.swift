//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Paweł Rudnik on 19/02/2024.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel    = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        addSubviews(messageLabel, logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {

        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        // !!! no messageLabel.translatesAutoresizingMaskIntoConstraints = false, because it is an instance of GFTitleLabel which has it set to false in GFTitleLabel.swift
        
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -150
        let messageLabelCenterYConstraint = messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            // messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150), // moving it up 150 points from the center to the right
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    private func configureLogoImageView() {
    
        logoImageView.image         = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomConstraint = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([

            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3), // take our image and make the width of the image 30% larger than the actual width of the screen
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170)
            // logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
            
        ])
    }
}
