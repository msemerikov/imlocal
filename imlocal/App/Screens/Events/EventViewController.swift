//
//  EventViewController.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 07.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Constants and variables
    var event: HappeningResult?
    private let scrollView = UIScrollView()
    private let eventImage = UIImageView()
    private let closeButton = UIButton()
    private let likeButton = UIButton()
    private let shareButton = UIButton()
    private let titleLabel = UILabel()
    private let stackView = UIView()
    private let locationImage = UIImageView()
    private let locationLabel = UILabel()
    private let dateImage = UIImageView()
    private let dateLabel = UILabel()
    private let priceImage = UIImageView()
    private let priceLabel = UILabel()
    private let aboutLabel = UILabel()
    private let descLabel = UILabel()
    
    private let width = UIScreen.main.bounds.width
    private var heightScroll = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .white
        setupScrollView()
        setupEventImage()
        setupCloseButton()
        setupLikeButton()
        setupShareButton()
        setupTitleLabel()
        setupStackView()
        setupLocationImage()
        setupLocationLabel()
        setupDateImage()
        setupDateLabel()
        setupPriceImage()
        setupPriceLabel()
        setupAboutLabel()
        setupDescLabel()
        setupFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private methods
    
    
    // MARK: - Setup views
    private func setupScrollView() {
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.frame.size.height).isActive = true
    }
    
    private func setupEventImage() {
        let height: CGFloat = 210
        heightScroll = Screen.statusBarHeight + height
        scrollView.addSubview(eventImage)
        eventImage.contentMode = .scaleToFill
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        eventImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        eventImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        eventImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        eventImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let image = event?.happeningPhotos?[0].happeningPhoto else { return }
        eventImage.downloaded(from: "https://atolserver.xyz/img/happeningPhoto/\(image)")
    }
    
    private func setupCloseButton() {
        let top: CGFloat = 19
        let leading: CGFloat = 15
        let size: CGFloat = 20
        
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "cross"), for: .normal)
        scrollView.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                         constant: top).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupLikeButton() {
        let trailing: CGFloat = 52
        let size: CGFloat = 26
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "LikeWhite"), for: .normal)
        likeButton.setImage(UIImage(named: "LikeSelected"), for: .selected)
        scrollView.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor,
                                             constant: -trailing).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupShareButton() {
        let trailing: CGFloat = 15
        let size: CGFloat = 26
        
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "ShareWhite"), for: .normal)
        shareButton.setImage(UIImage(named: "ShareSelected"), for: .selected)
        scrollView.addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        
        shareButton.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor,
                                              constant: -trailing).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupTitleLabel() {
        let bottom: CGFloat = 53
        let indent: CGFloat = 15
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = .mediumFont(size: 20)
        titleLabel.textColor = .white
        titleLabel.text = event?.title
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor,
                                            constant: indent).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor,
                                             constant: -indent).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: eventImage.bottomAnchor,
                                           constant: -bottom).isActive = true
    }
    
    private func setupStackView() {
        let top: CGFloat = 190
        let height: CGFloat = 80
        // -20 так как StackView перекрывает ImageView
        heightScroll = heightScroll + height - 20
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 15
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.layer.masksToBounds = false
        stackView.layer.shadowColor = UIColor.shadowColor.cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 5
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: top).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLocationImage() {
        let width: CGFloat = 15
        let height: CGFloat = 20
        let leading: CGFloat = 18
        let top: CGFloat = 15
        locationImage.image = UIImage(named: "Location")
        stackView.addSubview(locationImage)
        
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                               constant: leading).isActive = true
        locationImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        locationImage.topAnchor.constraint(equalTo: stackView.topAnchor,
                                           constant: top).isActive = true
        locationImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLocationLabel() {
        let leading: CGFloat = 44
        let trailing: CGFloat = 18
        let height: CGFloat = 17
        
        locationLabel.numberOfLines = 1
        locationLabel.textAlignment = .left
        locationLabel.font = .mediumFont(size: 14)
        locationLabel.textColor = .black
        locationLabel.text = event?.address
        stackView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                               constant: leading).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                constant: -trailing).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupDateImage() {
        let size: CGFloat = 20
        let top: CGFloat = 10
        dateImage.image = UIImage(named: "Watch")
        stackView.addSubview(dateImage)
        
        dateImage.translatesAutoresizingMaskIntoConstraints = false
        dateImage.centerXAnchor.constraint(equalTo: locationImage.centerXAnchor).isActive = true
        dateImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        dateImage.topAnchor.constraint(equalTo: locationImage.bottomAnchor,
                                       constant: top).isActive = true
        dateImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupDateLabel() {
        let leading: CGFloat = 44
        let trailing: CGFloat = 132
        let height: CGFloat = 17
        
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        dateLabel.font = .mediumFont(size: 14)
        dateLabel.textColor = .black
        dateLabel.text = convertDate(date: event?.begin)
        stackView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                           constant: leading).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                            constant: -trailing).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPriceImage() {
        let width: CGFloat = 15
        let height: CGFloat = 20
        let leading: CGFloat = 203
        let top: CGFloat = 10
        priceImage.image = UIImage(named: "Ticket")
        stackView.addSubview(priceImage)
        
        priceImage.translatesAutoresizingMaskIntoConstraints = false
        priceImage.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                            constant: leading).isActive = true
        priceImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        priceImage.topAnchor.constraint(equalTo: locationImage.bottomAnchor,
                                        constant: top).isActive = true
        priceImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPriceLabel() {
        let leading: CGFloat = 12
        let trailing: CGFloat = 18
        let height: CGFloat = 17
        
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .left
        priceLabel.font = .mediumFont(size: 14)
        priceLabel.textColor = .black
        stackView.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leadingAnchor.constraint(equalTo: priceImage.trailingAnchor,
                                            constant: leading).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                             constant: -trailing).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let price = event?.price else { return }
        priceLabel.text = getPriceString(price: price)
    }
    
    private func setupAboutLabel() {
        let leading: CGFloat = 14
        let top: CGFloat = 15
        let height: CGFloat = 20
        heightScroll = heightScroll + top + height
        
        aboutLabel.numberOfLines = 1
        aboutLabel.textAlignment = .left
        aboutLabel.font = .mediumFont(size: 16)
        aboutLabel.textColor = .black
        aboutLabel.text = "О событии"
        scrollView.addSubview(aboutLabel)
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                        constant: top).isActive = true
        aboutLabel.widthAnchor.constraint(equalToConstant: width - (2 * leading)).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupDescLabel() {
        let text = event?.description
        let leading: CGFloat = 14
        let top: CGFloat = 16
        let height: CGFloat = (text?.height(withConstrainedWidth: width - (2 * leading),
                                            font: .regularFont(size: 14)) ?? 50)
        heightScroll = heightScroll + top + height
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.font = .regularFont(size: 14)
        descLabel.textColor = .black
        descLabel.text = text
        scrollView.addSubview(descLabel)
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        descLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor,
                                       constant: top).isActive = true
        descLabel.widthAnchor.constraint(equalToConstant: width - (2 * leading)).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupFooterView() {
        let height: CGFloat = 80
        let top: CGFloat = 10
        let footerView = FooterView()
        heightScroll = heightScroll + top + height
        scrollView.contentSize = CGSize(width: width, height: heightScroll)
        scrollView.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        footerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: height).isActive = true
        if heightScroll > Screen.height {
            footerView.topAnchor.constraint(equalTo: descLabel.bottomAnchor,
                                            constant: top).isActive = true
        } else {
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
    }
    
    @objc private func closeButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func likeButtonPressed() {
        likeButton.isSelected = !likeButton.isSelected
    }
    
    @objc private func shareButtonPressed() {
        
    }
    
    /// Преобразование формата стоимости события
    /// - Parameter price: стоимость
    private func getPriceString(price: String) -> String {
        return price == "0" ? "Бесплатно" : "\(price) ₽"
    }
    
    /// Преобразование формата даты
    /// - Parameter date: дата с сервера
    private func convertDate(date: String?) -> String? {
        guard let date = date else { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        guard let dateDate = dateFormatter.date(from: date) else { return nil }
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"
        dateFormatter.timeZone = .autoupdatingCurrent
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: dateDate)
    }
    
}
