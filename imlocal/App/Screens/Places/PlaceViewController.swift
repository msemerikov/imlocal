//
//  PlaceViewController.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 12.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Constants and variables
    var place: PlacesResult?
    private let scrollView = UIScrollView()
    private let placeImage = UIImageView()
    private let closeButton = UIButton()
    private let likeButton = UIButton()
    private let shareButton = UIButton()
    private let titleLabel = UILabel()
    private let placeTypeLabel = UILabel()
    private let ratingButton = UIButton()
    private let ratingLabel = UILabel()
    private let stackView = UIView()
    private let locationImage = UIImageView()
    private let locationLabel = UILabel()
    private let dateImage = UIImageView()
    private let dateLabel = UILabel()
    private let phoneImage = UIImageView()
    private let phoneLabel = UILabel()
    private let webImage = UIImageView()
    private let webLabel = UILabel()
    private let priceImage = UIImageView()
    private let priceLabel = UILabel()
    private let newsLabel = UILabel()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let aboutLabel = UILabel()
    private let descLabel = UILabel()
    private let menuButton = UIButton()
    private let eventLabel = UILabel()
    private var tableView = UITableView()
    
    private var heightScroll = Screen.height
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .imlocalBackgroundColor
        setupScrollView()
        setupPlaceImage()
        setupCloseButton()
        setupLikeButton()
        setupShareButton()
        setupTitleLabel()
        setupPlaceTypeLabel()
        setupRatingButton()
        setupRatingLabel()
        setupStackView()
        setupLocationImage()
        setupLocationLabel()
        setupDateImage()
        setupDateLabel()
        setupPhoneImage()
        setupPhoneLabel()
        setupWebImage()
        setupWebLabel()
        setupPriceImage()
        setupPriceLabel()
        setupNewsLabel()
        setupCollectionView()
        setupAboutLabel()
        setupDescLabel()
        setupMenuButton()
        setupEventLabel()
        setupTableView()
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
    
    private func setupPlaceImage() {
        let height: CGFloat = 210
        heightScroll = Screen.statusBarHeight + height
        scrollView.addSubview(placeImage)
        placeImage.contentMode = .scaleToFill
        
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        placeImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        placeImage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        placeImage.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        placeImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let image = place?.shopPhotos?[0].shopPhoto else { return }
        placeImage.downloaded(from: "https://atolserver.xyz/img/shopPhoto/\(image)")
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
        let trailing: CGFloat = 54
        let size: CGFloat = 26
        
        likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        likeButton.setImage(UIImage(named: "LikeWhite"), for: .normal)
        likeButton.setImage(UIImage(named: "LikeSelected"), for: .selected)
        scrollView.addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.trailingAnchor.constraint(equalTo: placeImage.trailingAnchor,
                                            constant: -trailing).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupShareButton() {
        let leading: CGFloat = 15
        let size: CGFloat = 26
        
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        shareButton.setImage(UIImage(named: "ShareWhite"), for: .normal)
        shareButton.setImage(UIImage(named: "ShareSelected"), for: .selected)
        scrollView.addSubview(shareButton)
        
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor).isActive = true
        shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor,
                                              constant: leading).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: size).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupTitleLabel() {
        let bottom: CGFloat = 73
        let leading: CGFloat = 14
        
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.font = .mediumFont(size: 20)
        titleLabel.textColor = .white
        titleLabel.text = place?.shopShortName
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: placeImage.bottomAnchor,
                                           constant: -bottom).isActive = true
    }
    
    private func setupPlaceTypeLabel() {
        let leading: CGFloat = 14
        let top: CGFloat = 6
        let height: CGFloat = 16
        
        placeTypeLabel.numberOfLines = 1
        placeTypeLabel.textAlignment = .left
        placeTypeLabel.font = .mediumFont(size: 16)
        placeTypeLabel.textColor = .imlocalLightGray
        placeTypeLabel.text = "\(place?.shopTypeId ?? 0)"
        scrollView.addSubview(placeTypeLabel)
        
        placeTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeTypeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        placeTypeLabel.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        placeTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: top).isActive = true
        placeTypeLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRatingButton() {
        let top: CGFloat = 156
        let trailing: CGFloat = 47
        let width: CGFloat = 68
        let height: CGFloat = 24
        
        ratingButton.addTarget(self, action: #selector(ratingButtonPressed), for: .touchUpInside)
        ratingButton.setTitle("Оценить", for: .normal)
        ratingButton.titleLabel?.font = .mediumFont(size: 14)
        ratingButton.setTitleColor(.white, for: .normal)
        ratingButton.backgroundColor = UIColor(red: 0.996, green: 0.541, blue: 0.502, alpha: 0.51)
        ratingButton.layer.cornerRadius = 5
        ratingButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        ratingButton.layer.masksToBounds = false
        scrollView.addSubview(ratingButton)
        
        ratingButton.translatesAutoresizingMaskIntoConstraints = false
        ratingButton.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                         constant: top).isActive = true
        ratingButton.trailingAnchor.constraint(equalTo: placeImage.trailingAnchor,
                                             constant: -trailing).isActive = true
        ratingButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        ratingButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRatingLabel() {
        let top: CGFloat = 156
        let trailing: CGFloat = 15
        let width: CGFloat = 32
        let height: CGFloat = 24
        
        ratingLabel.numberOfLines = 1
        ratingLabel.textAlignment = .center
        ratingLabel.font = .mediumFont(size: 14)
        ratingLabel.textColor = .white
        ratingLabel.backgroundColor = .imlocalMainColor
        ratingLabel.layer.cornerRadius = 5
        ratingLabel.clipsToBounds = true
        ratingLabel.text = formatRating(place?.shopAvgRating)
        scrollView.addSubview(ratingLabel)
        
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.topAnchor.constraint(equalTo: scrollView.topAnchor,
                                         constant: top).isActive = true
        ratingLabel.trailingAnchor.constraint(equalTo: placeImage.trailingAnchor,
                                              constant: -trailing).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupStackView() {
        let top: CGFloat = -20
        let height: CGFloat = 110
        heightScroll = heightScroll + height + top
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
        stackView.topAnchor.constraint(equalTo: placeImage.bottomAnchor,
                                       constant: top).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
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
        stackView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                               constant: leading).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                                constant: -trailing).isActive = true
        locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let city = place?.shopAddress?.city,
            let street = place?.shopAddress?.street,
            let houseNumber = place?.shopAddress?.houseNumber else { return }
        locationLabel.text = "\(city), \(street), \(houseNumber)"
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
        let width: CGFloat = 120
        let height: CGFloat = 17
        
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        dateLabel.font = .mediumFont(size: 14)
        dateLabel.textColor = .black
        dateLabel.text = place?.shopWorkTime
        stackView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                           constant: leading).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPhoneImage() {
        let size: CGFloat = 20
        let top: CGFloat = 10
        phoneImage.image = UIImage(named: "Phone")
        stackView.addSubview(phoneImage)
        
        phoneImage.translatesAutoresizingMaskIntoConstraints = false
        phoneImage.centerXAnchor.constraint(equalTo: locationImage.centerXAnchor).isActive = true
        phoneImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        phoneImage.topAnchor.constraint(equalTo: dateImage.bottomAnchor,
                                       constant: top).isActive = true
        phoneImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupPhoneLabel() {
        let leading: CGFloat = 44
        let width: CGFloat = 120
        let height: CGFloat = 17
        
        phoneLabel.numberOfLines = 1
        phoneLabel.textAlignment = .left
        phoneLabel.font = .mediumFont(size: 14)
        phoneLabel.textColor = .black
        phoneLabel.text = place?.shopPhone
        stackView.addSubview(phoneLabel)
        
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                           constant: leading).isActive = true
        phoneLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        phoneLabel.centerYAnchor.constraint(equalTo: phoneImage.centerYAnchor).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupWebImage() {
        let size: CGFloat = 20
        let trailing: CGFloat = 140
        webImage.image = UIImage(named: "Web")
        stackView.addSubview(webImage)
        
        webImage.translatesAutoresizingMaskIntoConstraints = false
        webImage.centerYAnchor.constraint(equalTo: dateImage.centerYAnchor).isActive = true
        webImage.widthAnchor.constraint(equalToConstant: size).isActive = true
        webImage.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                       constant: -trailing).isActive = true
        webImage.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    private func setupWebLabel() {
        let leading: CGFloat = 9
        let height: CGFloat = 17
        
        webLabel.numberOfLines = 1
        webLabel.textAlignment = .left
        webLabel.font = .mediumFont(size: 14)
        webLabel.textColor = .black
        webLabel.text = place?.shopWeb
        stackView.addSubview(webLabel)
        
        webLabel.translatesAutoresizingMaskIntoConstraints = false
        webLabel.leadingAnchor.constraint(equalTo: webImage.trailingAnchor,
                                           constant: leading).isActive = true
        webLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                           constant: -leading).isActive = true
        webLabel.centerYAnchor.constraint(equalTo: webImage.centerYAnchor).isActive = true
        webLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPriceImage() {
        let width: CGFloat = 15
        let height: CGFloat = 20
        priceImage.image = UIImage(named: "Ticket")
        stackView.addSubview(priceImage)
        
        priceImage.translatesAutoresizingMaskIntoConstraints = false
        priceImage.centerXAnchor.constraint(equalTo: webImage.centerXAnchor).isActive = true
        priceImage.centerYAnchor.constraint(equalTo: phoneImage.centerYAnchor).isActive = true
        priceImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        priceImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupPriceLabel() {
        let leading: CGFloat = 9
        let height: CGFloat = 17
        
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .left
        priceLabel.font = .mediumFont(size: 14)
        priceLabel.textColor = .black
        stackView.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.leadingAnchor.constraint(equalTo: webLabel.leadingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                             constant: -leading).isActive = true
        priceLabel.centerYAnchor.constraint(equalTo: phoneImage.centerYAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        guard let costMin = place?.shopCostMin,
            let costMax = place?.shopCostMax else { return }
        priceLabel.text = "\(costMin)-\(costMax)"
    }
    
    private func setupNewsLabel() {
        let leading: CGFloat = 14
        let top: CGFloat = 15
        let height: CGFloat = 20
        heightScroll = heightScroll + height + top
        newsLabel.numberOfLines = 1
        newsLabel.textAlignment = .left
        newsLabel.font = .mediumFont(size: 16)
        newsLabel.textColor = .black
        newsLabel.text = "Новости, акции"
        scrollView.addSubview(newsLabel)
        
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                           constant: leading).isActive = true
        newsLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                       constant: top).isActive = true
        newsLabel.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        newsLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupCollectionView() {
        let top: CGFloat = 15
        let leading: CGFloat = 15
        let height: CGFloat = 180
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        heightScroll = heightScroll + height + top
        scrollView.addSubview(collectionView)
        collectionView.register(PlaceEventCell.self, forCellWithReuseIdentifier: "PlaceEventCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: newsLabel.bottomAnchor,
                                            constant: top).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                constant: leading).isActive = true
        collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor,
                                              constant: -leading).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupAboutLabel() {
        let leading: CGFloat = 14
        let top: CGFloat = 25
        let height: CGFloat = 20
        heightScroll = heightScroll + height + top
        aboutLabel.numberOfLines = 1
        aboutLabel.textAlignment = .left
        aboutLabel.font = .mediumFont(size: 16)
        aboutLabel.textColor = .black
        aboutLabel.text = "О нас"
        scrollView.addSubview(aboutLabel)
        
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        aboutLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor,
                                         constant: top).isActive = true
        aboutLabel.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        aboutLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupDescLabel() {
        let text = place?.shopFullDescription
        let leading: CGFloat = 14
        let top: CGFloat = 10
        let height: CGFloat = (text?.height(withConstrainedWidth: Screen.width - (2 * leading),
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
        descLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor,
                                       constant: top).isActive = true
        descLabel.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupMenuButton() {
        let top: CGFloat = 20
        let leading: CGFloat = 14
        let height: CGFloat = 20
        heightScroll = heightScroll + height + top
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.mediumFont(size: 14),
            .foregroundColor: UIColor.imlocalLightGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "  Посмотреть меню, расписание, услуги",
                                                        attributes: attributes)
        
        menuButton.addTarget(self, action: #selector(ratingButtonPressed), for: .touchUpInside)
        menuButton.setAttributedTitle(attributeString, for: .normal)
        menuButton.setImage(UIImage(named: "Download"), for: .normal)
        menuButton.contentVerticalAlignment = .center
        menuButton.contentHorizontalAlignment = .left
        scrollView.addSubview(menuButton)
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.topAnchor.constraint(equalTo: descLabel.bottomAnchor,
                                         constant: top).isActive = true
        menuButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        menuButton.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        menuButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupEventLabel() {
        let leading: CGFloat = 14
        let top: CGFloat = 25
        let height: CGFloat = 20
        heightScroll = heightScroll + height + top
        eventLabel.numberOfLines = 1
        eventLabel.textAlignment = .left
        eventLabel.font = .mediumFont(size: 16)
        eventLabel.textColor = .black
        eventLabel.text = "События"
        scrollView.addSubview(eventLabel)
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                             constant: leading).isActive = true
        eventLabel.topAnchor.constraint(equalTo: menuButton.bottomAnchor,
                                         constant: top).isActive = true
        eventLabel.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        eventLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTableView() {
        let top: CGFloat = 16
        let leading: CGFloat = 14
        let height: CGFloat = 315
        heightScroll = heightScroll + height + top
        scrollView.addSubview(tableView)
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: eventLabel.bottomAnchor,
                                       constant: top).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leading).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: Screen.width - (2 * leading)).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupFooterView() {
        let height: CGFloat = 80
        let top: CGFloat = 10
        let footerView = FooterView()
        heightScroll = heightScroll + top + height
        scrollView.contentSize = CGSize(width: Screen.width, height: heightScroll)
        scrollView.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        footerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: height).isActive = true
        if heightScroll > Screen.height {
            footerView.topAnchor.constraint(equalTo: tableView.bottomAnchor,
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
    
    @objc private func ratingButtonPressed() {
        
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

// MARK: - Collection view
extension PlaceViewController: UICollectionViewDelegate { }

extension PlaceViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return place?.events?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceEventCell",
                                                      for: indexPath) as! PlaceEventCell
        cell.configure(place?.events?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let shareDetailViewController = ShareDetailViewController()
        shareDetailViewController.event = place?.events?[indexPath.row]
        navigationController?.pushViewController(shareDetailViewController, animated: true)
    }
    
}

// MARK: - Table view
extension PlaceViewController: UITableViewDelegate {}

extension PlaceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return place?.happenings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                       for: indexPath) as? EventCell
            else { return UITableViewCell() }
        
        cell.configure(place?.happenings?[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let eventViewController = EventViewController()
        eventViewController.event = place?.happenings?[indexPath.row]
        navigationController?.pushViewController(eventViewController, animated: true)
        
    }
    
}
// MARK: - UICollectionViewFlowLayout
extension PlaceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
    }
    
}
