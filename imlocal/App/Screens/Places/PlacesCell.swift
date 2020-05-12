//
//  PlacesCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 11.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class PlaceCell: UITableViewCell {
    private let stackView = UIView()
    private let placeImage = UIImageView()
    private let placeNameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let distanceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let separatorView = UIView()
    private let separatorHeight: CGFloat = 5
    private var stackViewHeight: NSLayoutConstraint?
    private var placeImageHeight: NSLayoutConstraint?
    private var placeNameLabelHeight: NSLayoutConstraint?
    private var descLabelHeight: NSLayoutConstraint?
    
    private let minimumStackHeight: CGFloat = 105
    private let trailingStackView: CGFloat = 2
    private let widthPlaceImage: CGFloat = 105
    private let topRatingLabel: CGFloat = 10
    private let trailingRatingLabel: CGFloat = 10
    private let heightRatingLabel: CGFloat = 24
    private let widthRatingLabel: CGFloat = 32
    private let leadingPlaceLabel: CGFloat = 9
    private let topPlaceLabel: CGFloat = 7
    private let topDistanceLabel: CGFloat = 2
    private let leadingDistanceLabel: CGFloat = 9
    private let heightDistanceLabel: CGFloat = 15
    private let topDescriptionLabel: CGFloat = 6
    private let leadingDescriptionLabel: CGFloat = 9
    
    private var placeName = ""
    private var placeDesc = ""
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        setupPlaceImage()
        setupRatingLabel()
        setupPlaceLabel()
        setupDistanceLabel()
        setupDescriptionLabel()
        setupSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup views
    /// Установка view для содержимого ячейки
    private func setupStackView() {
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 5
        stackView.layer.masksToBounds = false
        stackView.layer.shadowColor = UIColor.shadowColor.cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowOffset = CGSize(width: 1, height: 1)
        stackView.layer.shadowRadius = 1
        contentView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -trailingStackView).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
    }
    
    /// Установка фотографии места
    private func setupPlaceImage() {
        stackView.addSubview(placeImage)
        placeImage.layer.cornerRadius = 5
        placeImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        placeImage.layer.masksToBounds = false
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        placeImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        placeImage.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        placeImage.widthAnchor.constraint(equalToConstant: widthPlaceImage).isActive = true
    }
    
    /// Установка рейтинга места
    private func setupRatingLabel() {
        ratingLabel.numberOfLines = 1
        ratingLabel.textAlignment = .center
        ratingLabel.font = .mediumFont(size: 14)
        ratingLabel.textColor = .white
        ratingLabel.backgroundColor = .imlocalMainColor
        ratingLabel.layer.cornerRadius = 5
        ratingLabel.clipsToBounds = true
        stackView.addSubview(ratingLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: stackView.topAnchor,
                                         constant: topRatingLabel).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                              constant: -trailingRatingLabel).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: widthRatingLabel).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: heightRatingLabel).isActive = true
    }
    
    /// Установка названия места
    private func setupPlaceLabel() {
        placeNameLabel.numberOfLines = 0
        placeNameLabel.textAlignment = .left
        placeNameLabel.font = .mediumFont(size: 16)
        placeNameLabel.textColor = .black
        stackView.addSubview(placeNameLabel)
        
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.topAnchor.constraint(equalTo: stackView.topAnchor,
                                       constant: topPlaceLabel).isActive = true
        placeNameLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor,
                                            constant: leadingPlaceLabel).isActive = true
        placeNameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor,
                                             constant: -leadingPlaceLabel).isActive = true
    }
    
    /// Установка расстояния до места
    private func setupDistanceLabel() {
        distanceLabel.numberOfLines = 1
        distanceLabel.textAlignment = .left
        distanceLabel.font = .regularFont(size: 14)
        distanceLabel.textColor = .imlocalLightGray
        stackView.addSubview(distanceLabel)
        
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor,
                                            constant: leadingDistanceLabel).isActive = true
        distanceLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor,
                                             constant: -leadingDistanceLabel).isActive = true
        distanceLabel.topAnchor.constraint(equalTo: placeNameLabel.bottomAnchor,
                                           constant: topDistanceLabel).isActive = true
        distanceLabel.heightAnchor.constraint(equalToConstant: heightDistanceLabel).isActive = true
    }
    
    /// Установка описания места
    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        descriptionLabel.font = .regularFont(size: 14)
        descriptionLabel.textColor = .black
        stackView.addSubview(descriptionLabel)
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: placeImage.trailingAnchor,
                                            constant: leadingDescriptionLabel).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                             constant: -leadingDescriptionLabel).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor,
                                           constant: topDescriptionLabel).isActive = true
    }
    
    /// Установка разделителя между ячейками
    private func setupSeparatorView() {
        separatorView.backgroundColor = .clear
        contentView.addSubview(separatorView)
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: separatorHeight).isActive = true
    }
    
    /// Установка значений в поля ячейки и корректировка констрейнтов
    /// - Parameter place: место
    func configure(place: PlacesResult) {
        stackViewHeight?.isActive = false
        placeImageHeight?.isActive = false
        placeNameLabelHeight?.isActive = false
        descLabelHeight?.isActive = false
        
        let image = place.shopPhotos?[0].shopPhoto
        placeImage.downloaded(from: "https://atolserver.xyz/img/shopPhoto/\(image ?? "")")
        ratingLabel.text = formatRating(place.shopAvgRating)
        
        placeName = place.shopShortName ?? ""
        let widthName: CGFloat = Screen.width - 32 - widthPlaceImage - (leadingPlaceLabel * 2) - widthRatingLabel - trailingRatingLabel
        let heightName: CGFloat = placeName.height(withConstrainedWidth: widthName,
                                               font: .mediumFont(size: 16))
        placeNameLabel.text = placeName
        
        placeDesc = place.shopShortDescription ?? ""
        let widthDesc: CGFloat = Screen.width - 32 - widthPlaceImage - (leadingDescriptionLabel * 2)
        let heightDesc: CGFloat = placeDesc.height(withConstrainedWidth: widthDesc,
                                               font: .regularFont(size: 14))
        descriptionLabel.text = placeDesc
        
        let heightStack: CGFloat = topPlaceLabel + heightName + topDistanceLabel + heightDistanceLabel + topDescriptionLabel + heightDesc
        if heightStack < minimumStackHeight {
            stackViewHeight = stackView.heightAnchor.constraint(equalToConstant: minimumStackHeight)
            placeImageHeight = placeImage.heightAnchor.constraint(equalToConstant: minimumStackHeight)
        } else {
            stackViewHeight = stackView.heightAnchor.constraint(equalToConstant: heightStack)
            placeImageHeight = placeImage.heightAnchor.constraint(equalToConstant: heightStack)
        }
        stackViewHeight?.isActive = true
        placeImageHeight?.isActive = true
        placeNameLabelHeight = placeNameLabel.heightAnchor.constraint(equalToConstant: heightName)
        placeNameLabelHeight?.isActive = true
        descLabelHeight = descriptionLabel.heightAnchor.constraint(equalToConstant: heightDesc)
        descLabelHeight?.isActive = true
        guard let distance = place.distance else { return }
        distanceLabel.text = "\(distance) м от Вас"
    }
    
    /// Форматирование отображения рейтинга
    /// - Parameter rating: рейтинг
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
