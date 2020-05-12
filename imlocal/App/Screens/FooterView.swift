//
//  FooterView.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 08.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    // MARK: - Constants and variables
    private let aboutButton = UIButton()
    private let helpButton = UIButton()
    private let policyButton = UIButton()
    private let copyrightLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .imlocalBackgroundColor
        setupAboutButton()
        setupHelpButton()
        setupPolicyButton()
        setupCopyrightLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views
    private func setupAboutButton() {
        let top: CGFloat = 16
        let leading: CGFloat = 14
        let width: CGFloat = 71
        let height: CGFloat = 16
        
        aboutButton.addTarget(self, action: #selector(aboutButtonPressed), for: .touchUpInside)
        aboutButton.setTitle("О проекте", for: .normal)
        aboutButton.setTitleColor(.imlocalLightGray, for: .normal)
        aboutButton.titleLabel?.font = .regularFont(size: 14)
        aboutButton.contentVerticalAlignment = .center
        aboutButton.contentHorizontalAlignment = .left
        self.addSubview(aboutButton)
        
        aboutButton.translatesAutoresizingMaskIntoConstraints = false
        aboutButton.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: top).isActive = true
        aboutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: leading).isActive = true
        aboutButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        aboutButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupHelpButton() {
        let top: CGFloat = 16
        let leading: CGFloat = 18
        let width: CGFloat = 71
        let height: CGFloat = 16
        
        helpButton.addTarget(self, action: #selector(helpButtonPressed), for: .touchUpInside)
        helpButton.setTitle("Помощь", for: .normal)
        helpButton.setTitleColor(.imlocalLightGray, for: .normal)
        helpButton.titleLabel?.font = .regularFont(size: 14)
        helpButton.contentVerticalAlignment = .center
        helpButton.contentHorizontalAlignment = .left
        self.addSubview(helpButton)
        
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: top).isActive = true
        helpButton.leadingAnchor.constraint(equalTo: aboutButton.trailingAnchor,
                                             constant: leading).isActive = true
        helpButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        helpButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPolicyButton() {
        let top: CGFloat = 16
        let leading: CGFloat = 14
        let width: CGFloat = 200
        let height: CGFloat = 16
        
        policyButton.addTarget(self, action: #selector(policyButtonPressed), for: .touchUpInside)
        policyButton.setTitle("Политика конфиденциальности", for: .normal)
        policyButton.setTitleColor(.imlocalLightGray, for: .normal)
        policyButton.titleLabel?.font = .regularFont(size: 14)
        policyButton.contentVerticalAlignment = .center
        policyButton.contentHorizontalAlignment = .left
        self.addSubview(policyButton)
        
        policyButton.translatesAutoresizingMaskIntoConstraints = false
        policyButton.topAnchor.constraint(equalTo: aboutButton.bottomAnchor,
                                         constant: top).isActive = true
        policyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: leading).isActive = true
        policyButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        policyButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupCopyrightLabel() {
        let trailing: CGFloat = 9
        let width: CGFloat = 99
        let height: CGFloat = 17
        
        copyrightLabel.font = .regularFont(size: 14)
        copyrightLabel.textColor = .imlocalLightGray
        copyrightLabel.textAlignment = .left
        copyrightLabel.numberOfLines = 1
        copyrightLabel.text = "© 2019, i’m local"
        self.addSubview(copyrightLabel)
        
        copyrightLabel.translatesAutoresizingMaskIntoConstraints = false
        copyrightLabel.centerYAnchor.constraint(equalTo: policyButton.centerYAnchor).isActive = true
        copyrightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -trailing).isActive = true
        copyrightLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func aboutButtonPressed() {
        print("about")
    }
    
    @objc private func helpButtonPressed() {
        print("help")
    }
    
    @objc private func policyButtonPressed() {
        print("policy")
    }
    
}
