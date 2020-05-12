//
//  ShareDetailViewController.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 10.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class ShareDetailViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Constants and variables
    var event: EventsResult?
    private let scrollView = UIScrollView()
    private let closeButton = UIButton()
    private let topStackView = UIView()
    private let shopImage = UIImageView()
    private let shopLabel = UILabel()
    private let shopAddress = UILabel()
    private let eventImage = UIImageView()
    private let titleLabel = UILabel()
    private let descLabel = UILabel()
    private let bottomStackView = UIView()
    private let likeButton = UIButton()
    private let shareButton = UIButton()
    private let dateLabel = UILabel()
    
    private let leadingShopImage: CGFloat = 15
    private let sizeShopImage: CGFloat = 50
    
    private let width = UIScreen.main.bounds.width
    private var heightScroll = UIScreen.main.bounds.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .imlocalBackgroundColor
        setupScrollView()
        setupCloseButton()
        setupTopStackView()
        setupShopImage()
        setupShopLabel()
        setupShopAddress()
        setupEventImage()
        setupTitleLabel()
        setupDescLabel()
        setupBottomStackView()
        setupLikeButton()
        setupShareButton()
        setupDateLabel()
        setupFooterView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = true
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
    
    private func setupCloseButton() {
        let top: CGFloat = 19
        let leading: CGFloat = 15
        let size: CGFloat = 20
        heightScroll = Screen.statusBarHeight + top + size
        
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
    
    private func setupTopStackView() {
        let top: CGFloat = 21
        let height: CGFloat = 50
        heightScroll = heightScroll + height + top
        scrollView.addSubview(topStackView)
        
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        topStackView.topAnchor.constraint(equalTo: closeButton.bottomAnchor,
                                       constant: top).isActive = true
        topStackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        topStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка логотипа компании проводящей акцию
    private func setupShopImage() {
        topStackView.addSubview(shopImage)
        shopImage.contentMode = .scaleAspectFill
        shopImage.layer.cornerRadius = sizeShopImage / 2
        shopImage.clipsToBounds = true
        
        shopImage.translatesAutoresizingMaskIntoConstraints = false
        shopImage.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor,
                                           constant: leadingShopImage).isActive = true
        shopImage.topAnchor.constraint(equalTo: topStackView.topAnchor).isActive = true
        shopImage.widthAnchor.constraint(equalToConstant: sizeShopImage).isActive = true
        shopImage.heightAnchor.constraint(equalToConstant: sizeShopImage).isActive = true
        
        guard let image = event?.shop.shopPhotos[0].shopPhoto else { return }
        shopImage.downloaded(from: "https://atolserver.xyz/img/shopPhoto/\(image)")
    }
    
    /// Установка названия компании проводящей акцию
    private func setupShopLabel() {
        let indent: CGFloat = 9
        let top: CGFloat = 4
        let height: CGFloat = 20
        
        shopLabel.numberOfLines = 1
        shopLabel.textAlignment = .left
        shopLabel.font = .mediumFont(size: 16)
        shopLabel.textColor = .black
        shopLabel.text = event?.shop.shopShortName
        topStackView.addSubview(shopLabel)
        
        shopLabel.translatesAutoresizingMaskIntoConstraints = false
        shopLabel.leadingAnchor.constraint(equalTo: shopImage.trailingAnchor,
                                           constant: indent).isActive = true
        shopLabel.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                            constant: indent).isActive = true
        shopLabel.topAnchor.constraint(equalTo: topStackView.topAnchor,
                                       constant: top).isActive = true
        shopLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupShopAddress() {
        let indent: CGFloat = 9
        let top: CGFloat = 3
        let height: CGFloat = 19
        
        shopAddress.numberOfLines = 1
        shopAddress.textAlignment = .left
        shopAddress.font = .regularFont(size: 14)
        shopAddress.textColor = .imlocalLightGray
        topStackView.addSubview(shopAddress)
        
        shopAddress.translatesAutoresizingMaskIntoConstraints = false
        shopAddress.leadingAnchor.constraint(equalTo: shopImage.trailingAnchor,
                                             constant: indent).isActive = true
        shopAddress.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor,
                                              constant: indent).isActive = true
        shopAddress.topAnchor.constraint(equalTo: shopLabel.bottomAnchor,
                                         constant: top).isActive = true
        shopAddress.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let city = event?.shop.shopAddress?.city,
            let street = event?.shop.shopAddress?.street,
            let houseNumber = event?.shop.shopAddress?.houseNumber else { return }
        shopAddress.text = "\(city), \(street), \(houseNumber)"
    }
    
    private func setupEventImage() {
        let height: CGFloat = 250
        let top: CGFloat = 10
        heightScroll = heightScroll + height + top
        eventImage.contentMode = .scaleToFill
        eventImage.clipsToBounds = true
        scrollView.addSubview(eventImage)
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        eventImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        eventImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        eventImage.topAnchor.constraint(equalTo: shopImage.bottomAnchor,
                                        constant: top).isActive = true
        eventImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let image = event?.eventPhotos[0].eventPhoto else { return }
        eventImage.downloaded(from: "https://atolserver.xyz/img/eventPhoto/\(image)")
    }
    
    private func setupTitleLabel() {
        let top: CGFloat = 16
        let height: CGFloat = 20
        let indent: CGFloat = 14
        heightScroll = heightScroll + height + top
        
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = .mediumFont(size: 16)
        titleLabel.textColor = .black
        titleLabel.text = event?.title
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: indent).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width - (2 * indent)).isActive = true
        titleLabel.topAnchor.constraint(equalTo: eventImage.bottomAnchor,
                                           constant: top).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupDescLabel() {
        let text = event?.fullDesc
        let leading: CGFloat = 14
        let top: CGFloat = 6
        let height: CGFloat = (text?.height(withConstrainedWidth: width - (2 * leading),
                                            font: .regularFont(size: 14)) ?? 50)
        heightScroll = heightScroll + height + top
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.font = .regularFont(size: 14)
        descLabel.textColor = .black
        descLabel.text = text
        scrollView.addSubview(descLabel)
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: top).isActive = true
        descLabel.widthAnchor.constraint(equalToConstant: width - (2 * leading)).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupBottomStackView() {
        let top: CGFloat = 17
        let height: CGFloat = 26
        heightScroll = heightScroll + height + top
        scrollView.addSubview(bottomStackView)
        
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        bottomStackView.topAnchor.constraint(equalTo: descLabel.bottomAnchor,
                                       constant: top).isActive = true
        bottomStackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        bottomStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLikeButton() {
        let leading: CGFloat = 14
        let size: CGFloat = 26
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "Like"), for: .normal)
        likeButton.setImage(UIImage(named: "LikeSelected"), for: .selected)
        bottomStackView.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor,
                                            constant: leading).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupShareButton() {
        let leading: CGFloat = 8
        let size: CGFloat = 26
        
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "Share-1"), for: .normal)
        shareButton.setImage(UIImage(named: "ShareSelected"), for: .selected)
        bottomStackView.addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor,
                                              constant: leading).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupDateLabel() {
        let indent: CGFloat = 14
        let height: CGFloat = 13
        
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .right
        dateLabel.font = .regularFont(size: 14)
        dateLabel.textColor = .imlocalLightGray
        bottomStackView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: shareButton.trailingAnchor,
                                           constant: indent).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor,
                                            constant: -indent).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: bottomStackView.centerYAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let begin = event?.begin,
            let end = event?.end else { return }
        if begin == end {
            dateLabel.text = begin
        } else {
            dateLabel.text = "\(begin) - \(end)"
        }
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
            footerView.topAnchor.constraint(equalTo: bottomStackView.bottomAnchor,
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
