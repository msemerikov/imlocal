//
//  ShareCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 07.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class ShareCell: UITableViewCell {
    private let shopImage = UIImageView()
    private let shopLabel = UILabel()
    private let ratingLabel = UILabel()
    private let eventImage = UIImageView()
    private let eventLabel = UILabel()
    private let stackView = UIView()
    private let descriptionLabel = UILabel()
    private let likeButton = UIButton()
    private let shareButton = UIButton()
    private let dateLabel = UILabel()
    private let separatorView = UIView()
    private let separatorHeight: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupShopImage()
        setupRatingLabel()
        setupShopLabel()
        setupStackView()
        setupEventImage()
        setupEventLabel()
        setupDescriptionLabel()
        setupLikeButton()
        setupShareButton()
        setupDateLabel()
        setupSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views
    /// Установка логотипа компании проводящей акцию
    private func setupShopImage() {
        let size: CGFloat = 30
        contentView.addSubview(shopImage)
        shopImage.contentMode = .scaleAspectFill
        shopImage.layer.cornerRadius = size / 2
        shopImage.clipsToBounds = true
        
        shopImage.translatesAutoresizingMaskIntoConstraints = false
        shopImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        shopImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        shopImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        shopImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    /// Установка рейтинга мероприятия
    private func setupRatingLabel() {
        let height: CGFloat = 24
        let width: CGFloat = 32
        
        ratingLabel.numberOfLines = 1
        ratingLabel.textAlignment = .center
        ratingLabel.font = .mediumFont(size: 14)
        ratingLabel.textColor = .white
        ratingLabel.backgroundColor = .imlocalMainColor
        ratingLabel.layer.cornerRadius = 5
        ratingLabel.clipsToBounds = true
        contentView.addSubview(ratingLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        ratingLabel.centerYAnchor.constraint(equalTo: shopImage.centerYAnchor).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка названия компании проводящей акцию
    private func setupShopLabel() {
        let indent: CGFloat = 9
        
        shopLabel.numberOfLines = 1
        shopLabel.textAlignment = .left
        shopLabel.font = .mediumFont(size: 16)
        shopLabel.textColor = .black
        contentView.addSubview(shopLabel)
        
        shopLabel.translatesAutoresizingMaskIntoConstraints = false
        shopLabel.leadingAnchor.constraint(equalTo: shopImage.trailingAnchor,
                                            constant: indent).isActive = true
        shopLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor,
                                             constant: -indent).isActive = true
        shopLabel.centerYAnchor.constraint(equalTo: shopImage.centerYAnchor).isActive = true
    }
    
    /// Установка картинки мероприятия
    private func setupEventImage() {
        let top: CGFloat = 10
        let height: CGFloat = 230
        contentView.addSubview(eventImage)
        eventImage.contentMode = .scaleAspectFill
        eventImage.layer.cornerRadius = 5
        eventImage.clipsToBounds = true
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventImage.topAnchor.constraint(equalTo: shopImage.bottomAnchor,
                                        constant: top).isActive = true
        eventImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        eventImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка названия события
    private func setupEventLabel() {
        let bottom: CGFloat = 16
        let indent: CGFloat = 9
        
        eventLabel.numberOfLines = 0
        eventLabel.textAlignment = .left
        eventLabel.font = .boldFont(size: 20)
        eventLabel.textColor = .white
        contentView.addSubview(eventLabel)
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor,
                                            constant: indent).isActive = true
        eventLabel.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor,
                                             constant: -indent).isActive = true
        eventLabel.bottomAnchor.constraint(equalTo: eventImage.bottomAnchor,
                                           constant: -bottom).isActive = true
    }
    
    /// Установка view с описанием и кнопками
    private func setupStackView() {
        let top: CGFloat = 235
        let height: CGFloat = 110
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5
        stackView.layer.masksToBounds = false
        stackView.layer.shadowColor = UIColor.shadowColor.cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 5
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: shopImage.bottomAnchor,
                                       constant: top).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка описания мероприятия
    private func setupDescriptionLabel() {
        let top: CGFloat = 21
        let indent: CGFloat = 9
        let height: CGFloat = 48
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .regularFont(size: 14)
        descriptionLabel.textColor = .black
        stackView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                            constant: indent).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                             constant: -indent).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: stackView.topAnchor,
                                           constant: top).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки "Нравится"
    private func setupLikeButton() {
        let top: CGFloat = 2
        let leading: CGFloat = 10
        let size: CGFloat = 26
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "Like"), for: .normal)
        likeButton.setImage(UIImage(named: "LikeSelected"), for: .selected)
        contentView.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                        constant: top).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                            constant: leading).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    /// Установка кнопки "Поделиться"
    private func setupShareButton() {
        let top: CGFloat = 2
        let leading: CGFloat = 10
        let size: CGFloat = 26
        
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "Share-1"), for: .normal)
        shareButton.setImage(UIImage(named: "ShareSelected"), for: .selected)
        contentView.addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,
                                        constant: top).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor,
                                            constant: leading).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    /// Установка времени начала события
    private func setupDateLabel() {
        let indent: CGFloat = 8
        let height: CGFloat = 15
        
        dateLabel.textAlignment = .right
        dateLabel.font = .regularFont(size: 14)
        dateLabel.textColor = .black
        contentView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                           constant: -indent).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка разделителя между ячейками
    private func setupSeparatorView() {
        separatorView.backgroundColor = .white
        contentView.addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: separatorHeight).isActive = true
    }
    
    /// Установка значений в поля ячейки
    /// - Parameter event: мероприятие
    func configure(event: EventsResult) {
        let imageShop = event.shop.shopPhotos[0].shopPhoto
        let imageEvent = event.eventPhotos[0].eventPhoto
        shopImage.downloaded(from: "https://atolserver.xyz/img/shopPhoto/\(imageShop ?? "")")
        shopLabel.text = event.shop.shopShortName
        ratingLabel.text = formatRating(event.shop.shopAvgRating)
        eventImage.downloaded(from: "https://atolserver.xyz/img/eventPhoto/\(imageEvent ?? "")")
        eventLabel.text = event.title
        descriptionLabel.text = event.shortDesc
        guard let begin = event.begin,
            let end = event.end else { return }
        if begin == end {
            dateLabel.text = begin
        } else {
            dateLabel.text = "\(begin) - \(end)"
        }
        
    }
    
    @objc private func likeButtonPressed() {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    @objc private func shareButtonPressed() {
        
    }
    
    private func formatRating(_ rating: String?) -> String? {
        if rating == nil {
            let color = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1)
            ratingLabel.backgroundColor = color
            return "0"
        } else {
            ratingLabel.backgroundColor = .imlocalMainColor
            guard let formattedRating = rating else { return rating }
            return String(formattedRating.dropLast(3))
        }
    }
    
}
