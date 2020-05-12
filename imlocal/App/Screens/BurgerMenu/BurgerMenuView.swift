//
//  BurgerMenuView.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 04.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

protocol BurgerMenuViewDelegate: AnyObject {
    func hideBurgerMenu()
}

class BurgerMenuView: UIView {
    
    var isLogged = false
    var buttonsArray: [ButtonsForBurgerMenu] = []
    weak var delegate: BurgerMenuViewDelegate?
    private let closeButton = UIButton()
    private let tableView = UITableView()
    
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let searchButton = UIButton()
    private let searchBar = UISearchBar()
    private let headerLabel = UILabel()
    private let lineView = UIView()
    
    private let array = ButtonsForScrollView.allButtonsForScrollView
    
    convenience init(title: String) {
        self.init()
        self.backgroundColor = .imlocalBackgroundColor
        
        if isLogged {
            buttonsArray = [ButtonsForBurgerMenu.user, ButtonsForBurgerMenu.favourites, ButtonsForBurgerMenu.help, ButtonsForBurgerMenu.business, ButtonsForBurgerMenu.exit]
        } else {
            buttonsArray = [ButtonsForBurgerMenu.user, ButtonsForBurgerMenu.help, ButtonsForBurgerMenu.business]
        }
        
        setupCloseButton()
        setupTableView()
    }
    
    // MARK: - Setup views
    /// Установка кнопки закрытия меню
    private func setupCloseButton() {
        let top: CGFloat = 18
        let leading: CGFloat = 21
        let width: CGFloat = 20
        let height: CGFloat = 20
        
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        closeButton.setImage(UIImage(named: "cross"), for: .normal)
        self.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: self.topAnchor,
                                         constant: top).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                             constant: leading).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопок
    private func setupTableView() {
        let top: CGFloat = 70
        self.addSubview(tableView)
        tableView.register(BurgerCell.self, forCellReuseIdentifier: "BurgerCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.topAnchor,
                                       constant: top).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    /// Закрытие "бургер" меню
    @objc private func closeButtonPressed() {
        delegate?.hideBurgerMenu()
    }
    
}

// MARK: - Table view
extension BurgerMenuView: UITableViewDelegate {}

extension BurgerMenuView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buttonsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BurgerCell",
                                                       for: indexPath) as? BurgerCell
            else { return UITableViewCell() }
        // TODO: - Заменить Степана
        if indexPath.row == 0 && isLogged {
            cell.configure("Степан",
                           UIImage(named: buttonsArray[indexPath.row].image)!)
        } else {
            cell.configure(buttonsArray[indexPath.row].title,
                           UIImage(named: buttonsArray[indexPath.row].image)!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
