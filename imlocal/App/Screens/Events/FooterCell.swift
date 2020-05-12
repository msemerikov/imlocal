//
//  FooterCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 07.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {

    // MARK: - Constants and variables
    private let titleLabel = UILabel()
    private let footerImageView = UIImageView()
    private let descLabel = UILabel()
    private let createEventButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupTitleLabel()
        setupFooterImageView()
        setupDescLabel()
        setupCreateEventButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views
    /// Установка заголовка
    private func setupTitleLabel() {
        let top: CGFloat = 7
        let height: CGFloat = 44
        
        titleLabel.font = .titleFont(size: 24)
        titleLabel.textColor = .imlocalMainColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.text = "Владелец бизнеса"
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка картинки
    private func setupFooterImageView() {
        let width: CGFloat = 160
        footerImageView.contentMode = .scaleAspectFit
        contentView.addSubview(footerImageView)
        
        footerImageView.translatesAutoresizingMaskIntoConstraints = false
        footerImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        footerImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        footerImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        footerImageView.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка описания
    private func setupDescLabel() {
        let height: CGFloat = 123
        
        descLabel.font = .regularFont(size: 14)
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        descLabel.numberOfLines = 0
        contentView.addSubview(descLabel)
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.topAnchor.constraint(equalTo: footerImageView.bottomAnchor).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки
    private func setupCreateEventButton() {
        let top: CGFloat = 20
        let width: CGFloat = 163
        let height: CGFloat = 35
        
        createEventButton.addTarget(self, action: #selector(createEventButtonPressed), for: .touchUpInside)
        createEventButton.setTitleColor(.white, for: .normal)
        createEventButton.titleLabel?.font = .mediumFont(size: 14)
        createEventButton.backgroundColor = .imlocalMainColor
        createEventButton.layer.cornerRadius = 5
        createEventButton.clipsToBounds = true
        createEventButton.contentHorizontalAlignment = .center
        createEventButton.contentVerticalAlignment = .center
        contentView.addSubview(createEventButton)
        
        createEventButton.translatesAutoresizingMaskIntoConstraints = false
        createEventButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor,
                                               constant: top).isActive = true
        createEventButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        createEventButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        createEventButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Конфигурирование ячейки
    /// - Parameter type: тип экрана вызвавшего ячейку
    func configure(type: ScreenType) {
        let color = UIColor(red: 0, green: 141 / 255, blue: 143 / 255, alpha: 1)
        switch type {
        case .events:
            descLabel.colorString(text: "Разместите событие здесь и придут соседи.\n\nБесплатный пробный период\nна размещение акций",
                                  coloredText: "Бесплатный",
                                  color: color)
            let logoImageName = "EventFooterImage"
            guard let image = UIImage(named: logoImageName) else {
                assertionFailure("Missing ​​\(logoImageName) asset")
                return
            }
            footerImageView.image = image
            createEventButton.setTitle("Разместить событие", for: .normal)
        case .places:
            descLabel.colorString(text: "Разместите Ваше место\nна платформе и станьте ближе\nк тысячам людей, которые живут и работают\nв радиусе пешей доступности.\n\nБесплатный пробный период\nна размещение акций.",
                                  coloredText: "Бесплатный",
                                  color: color)
            let logoImageName = "PlacesFooterImage"
            guard let image = UIImage(named: logoImageName) else {
                assertionFailure("Missing ​​\(logoImageName) asset")
                return
            }
            footerImageView.image = image
            createEventButton.setTitle("Попробовать", for: .normal)
        case .share:
            print("In develop")
        }
    }
    
    @objc private func createEventButtonPressed() {
        print("In develop")
    }
    
}
