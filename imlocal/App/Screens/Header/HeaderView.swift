//
//  HeaderView.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 31.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

protocol HeaderViewDelegate: AnyObject {
    func showBurgerMenu()
}

class HeaderView: UIView {
    
    // MARK: - Constants and variables
    weak var delegate: HeaderViewDelegate?
    weak var searchBarDelegate: UISearchBarDelegate?
    private let burgerButton = UIButton()
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let searchButton = UIButton()
    private let searchBar = UISearchBar()
    private let headerLabel = UILabel()
    private let lineView = UIView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private let array = ButtonsForScrollView.allButtonsForScrollView
    private var screenType: ScreenType = .places
    
    convenience init(type: ScreenType) {
        self.init()
        self.screenType = type
        self.backgroundColor = .imlocalBackgroundColor
        setupBurgerButton()
        setupLogoImage()
        setupTitleLabel()
        setupSearchButton()
        setupSearchBar()
        setupHeaderLabel()
        setupLineView()
        setupCollectionView()
    }
    
    // MARK: - Public methods
    /// Установка делегата для строки поиска
    func setSearchBarDelegate() {
        searchBar.delegate = searchBarDelegate
    }
    
    /// Скрытие строки поиска
    func hideSearchBar() {
        searchBar.isHidden = true
        searchButton.isHidden = false
    }
    
    // MARK: - Setup views
    /// Установка кнопки "бургер" меню
    private func setupBurgerButton() {
        let top: CGFloat = 19
        let leading: CGFloat = 16
        let width: CGFloat = 28
        let height: CGFloat = 20
        
        burgerButton.addTarget(self, action: #selector(burgerButtonPressed), for: .touchUpInside)
        burgerButton.setImage(UIImage(named: "MenuBtnIcon"), for: .normal)
        self.addSubview(burgerButton)
        
        burgerButton.translatesAutoresizingMaskIntoConstraints = false
        burgerButton.topAnchor.constraint(equalTo: self.topAnchor,
                                          constant: top).isActive = true
        burgerButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                              constant: leading).isActive = true
        burgerButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        burgerButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка логотипа
    private func setupLogoImage() {
        let top: CGFloat = 14
        let leading: CGFloat = 17
        let width: CGFloat = 30
        let logoImageName = "Vector"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        
        logoImage.image = image
        self.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: top).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: burgerButton.trailingAnchor,
                                           constant: leading).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// Установка названия приложения
    private func setupTitleLabel() {
        let top: CGFloat = 16
        let leading: CGFloat = 6
        let width: CGFloat = 93
        let height: CGFloat = 23
        
        titleLabel.font = .titleFont(size: 18)
        titleLabel.textColor = .imlocalMainColor
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        titleLabel.text = "i'm local"
        self.addSubview(titleLabel)//6 16
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                        constant: top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor,
                                            constant: leading).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки поиска
    private func setupSearchButton() {
        let top: CGFloat = 19
        let trailing: CGFloat = 25
        let width: CGFloat = 16
        let height: CGFloat = 20
        
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        searchButton.setImage(UIImage(named: "Search"), for: .normal)
        self.addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.topAnchor.constraint(equalTo: self.topAnchor,
                                          constant: top).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                               constant: -trailing).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка строки поиска
    private func setupSearchBar() {
        let top: CGFloat = 10
        let leading: CGFloat = 5
        let width: CGFloat = UIScreen.main.bounds.width - (leading * 2)
        let height: CGFloat = 38
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.imlocalMainColor]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.searchTextField.placeholder = "Поиск..."
        searchBar.searchTextField.textColor = .imlocalMainColor
        searchBar.searchTextField.font = .mediumFont(size: 14)
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.layer.backgroundColor = UIColor.white.cgColor
        searchBar.setImage(UIImage(named: "Search"), for: .search, state: .normal)
        searchBar.setImage(UIImage(named: "cross.pdf"), for: .clear, state: .normal)
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.layer.cornerRadius = height / 2
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchBarStyle = .minimal
        self.addSubview(searchBar)
        searchBar.isHidden = true
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                           constant: leading).isActive = true
        searchBar.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: top).isActive = true
        searchBar.widthAnchor.constraint(equalToConstant: width).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка заголовка
    private func setupHeaderLabel() {
        let top: CGFloat = 62
        let leading: CGFloat = 14
        let width: CGFloat = UIScreen.main.bounds.width - (leading * 2)
        let height: CGFloat = 23
        
        headerLabel.font = .mediumFont(size: 20)
        headerLabel.textColor = .black
        headerLabel.textAlignment = .left
        headerLabel.numberOfLines = 1
        self.addSubview(headerLabel)
        
        switch screenType {
        case .events:
            headerLabel.colorString(text: "События в разделе Еда",
                                    coloredText: "Еда",
                                    color: .imlocalMainColor)
        case .places:
            headerLabel.colorString(text: "Еда рядом с Вами",
                                    coloredText: "Еда",
                                    color: .imlocalMainColor)
        case .share:
            headerLabel.colorString(text: "Акции в разделе Еда",
                                    coloredText: "Еда",
                                    color: .imlocalMainColor)
        }
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: top).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: leading).isActive = true
        headerLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка линии под заголовком
    private func setupLineView() {
        let top: CGFloat = 15
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 1
        
        lineView.backgroundColor = .lightGray
        self.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor,
                                      constant: top).isActive = true
        lineView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: width).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка ячеек с категориями
    private func setupCollectionView() {
        let top: CGFloat = 15
        let width: CGFloat = UIScreen.main.bounds.width
        let height: CGFloat = 32
        let customSuperLayout = HeaderCollectionViewLayout()
        customSuperLayout.delegate = self
        customSuperLayout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.setCollectionViewLayout(customSuperLayout, animated: true)
        self.addSubview(collectionView)
        collectionView.register(HeaderCell.self, forCellWithReuseIdentifier: "HeaderCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .left)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor,
                                            constant: top).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalToConstant: width - 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func burgerButtonPressed() {
        delegate?.showBurgerMenu()
    }
    
    @objc private func searchButtonPressed() {
        searchBar.isHidden = false
        searchButton.isHidden = true
    }
    
}

// MARK: - Collection view
extension HeaderView: UICollectionViewDelegate { }

extension HeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell",
                                                      for: indexPath) as! HeaderCell
        cell.configure(array[indexPath.row].title)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let title = array[indexPath.row].title
        switch screenType {
        case .events:
            headerLabel.colorString(text: "События в разделе \(title)",
                coloredText: title,
                color: .imlocalMainColor)
        case .places:
            headerLabel.colorString(text: "\(title) рядом с Вами",
                coloredText: title,
                color: .imlocalMainColor)
        case .share:
            headerLabel.colorString(text: "Акции в разделе \(title)",
                coloredText: title,
                color: .imlocalMainColor)
        }
    }
    
}

extension HeaderView: HeaderCollectionViewLayoutDelegate {
    
    func width(forItemAt indexPath: IndexPath) -> CGFloat {
        let constraintRect = CGSize(width: self.frame.size.width - 10, height: 32)
        let data = array[indexPath.row].title
        let box = data.boundingRect(with: constraintRect,
                                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                    attributes: [NSAttributedString.Key.font: UIFont.mediumFont(size: 16)],
                                    context: nil)
        return box.width + 16
    }
    
}

