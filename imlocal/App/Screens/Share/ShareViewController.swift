//
//  ShareViewController.swift
//  imlocal
//
//  Created by Denis on 23.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController, Storyboarded {
    
    // MARK: - Constants and variables
    private let requestFactory = RequestFactory()
    private let headerView = HeaderView(type: .share)
    private var burgerMenu = BurgerMenuView()
    private let stackView = UIView()
    private let sortLabel = UILabel()
    private let sortButton = UIButton()
    private var tableView = UITableView()
    private var eventsArray: [EventsResult] = []
    private var filteredArray: [EventsResult] = []
    private var searchString = ""
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        getEvents()
        setupHeaderView()
        setupStackView()
        setupSortLabel()
        setupSortButton()
        setupTableView()
        setupBurgerMenu()
        setupToHideKeyboardOnTapOnView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Private methods
    /// Получение списка событий с сервера
    private func getEvents() {
        let events = requestFactory.makeEventsRequestFactory()
        events.eventsGet(page: 1, perPage: 10) { response in
            switch response.result {
            case .success(let events):
                self.eventsArray = events
                self.filteredArray = events
                self.reloadTableView()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Обновление таблицы
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    /// Обновление таблицы с учетом фильтров
    private func filter() {
        
        guard !searchString.isEmpty else {
            filteredArray = eventsArray
            reloadTableView()
            return
        }
        
        filteredArray = eventsArray.filter({
            ($0.title?.lowercased().contains(searchString.lowercased()))!
        })
        
        reloadTableView()
    }
    
    // MARK: - Setup views
    /// Установка хидера
    private func setupHeaderView() {
        headerView.delegate = self
        headerView.searchBarDelegate = self
        headerView.setSearchBarDelegate()
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 163).isActive = true
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    /// Установка "бургер" меню
    private func setupBurgerMenu() {
        let width = view.frame.width
        let height = view.frame.height
        burgerMenu = BurgerMenuView(title: "test")
        burgerMenu.delegate = self
        burgerMenu.isHidden = true
        view.addSubview(burgerMenu)
        
        burgerMenu.translatesAutoresizingMaskIntoConstraints = false
        burgerMenu.widthAnchor.constraint(equalToConstant: width * 0.6).isActive = true
        burgerMenu.heightAnchor.constraint(equalToConstant: height).isActive = true
        burgerMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        burgerMenu.trailingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    /// Установка view с выбором даты
    private func setupStackView() {
        let height: CGFloat = 38
        
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 15
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.layer.masksToBounds = false
        stackView.layer.shadowColor = UIColor.shadowColor.cgColor
        stackView.layer.shadowOpacity = 1
        stackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        stackView.layer.shadowRadius = 5
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSortLabel() {
        let leading: CGFloat = 15
        let height: CGFloat = 17
        let width: CGFloat = 90
        
        sortLabel.numberOfLines = 1
        sortLabel.textAlignment = .left
        sortLabel.font = .regularFont(size: 14)
        sortLabel.textColor = .imlocalLightGray
        sortLabel.text = "Сортировать"
        stackView.addSubview(sortLabel)
        
        sortLabel.translatesAutoresizingMaskIntoConstraints = false
        sortLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                           constant: leading).isActive = true
        sortLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        sortLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        sortLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupSortButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.mediumFont(size: 14),
            .foregroundColor: UIColor.imlocalMainColor]
        let attributeString = NSMutableAttributedString(string: "по рейтингу ",
                                                        attributes: attributes)
        let trailing: CGFloat = 15
        let width: CGFloat = 110
        let height: CGFloat = 17
        
        sortButton.addTarget(self, action: #selector(sortButtonPressed), for: .touchUpInside)
        sortButton.semanticContentAttribute = .forceRightToLeft
        sortButton.setAttributedTitle(attributeString, for: .normal)
        sortButton.setImage(UIImage(named: "Arrow"), for: .normal)
        sortButton.contentVerticalAlignment = .center
        sortButton.contentHorizontalAlignment = .right
        stackView.addSubview(sortButton)
        
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        sortButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                             constant: -trailing).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка таблицы событий
    private func setupTableView() {
        let top: CGFloat = 216
        let indent: CGFloat = 15
        view.addSubview(tableView)
        tableView.register(ShareCell.self, forCellReuseIdentifier: "ShareCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: top).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: indent).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                            constant: -indent).isActive = true
    }
    
    // MARK: - Buttons methods
    /// Выбор даты для фильтрации событий
    @objc private func sortButtonPressed() {
        print("Сортировка")
    }
    
}

extension ShareViewController: HeaderViewDelegate {
    
    /// Показ "бургер" меню
    func showBurgerMenu() {
        let width = view.frame.width
        burgerMenu.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.burgerMenu.frame.origin.x += width * 0.6
        }
    }
    
}

extension ShareViewController: BurgerMenuViewDelegate {
    
    /// Скрытие "бургер" меню
    func hideBurgerMenu() {
        let width = view.frame.width
        UIView.animate(withDuration: 0.5, animations: {
            self.burgerMenu.frame.origin.x -= width * 0.6
        }, completion: { (finished) -> Void in
            self.burgerMenu.isHidden = true
        })
    }
    
}

// MARK: - Table view
extension ShareViewController: UITableViewDelegate {}

extension ShareViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShareCell",
                                                       for: indexPath) as? ShareCell
            else { return UITableViewCell() }
        
        cell.configure(event: filteredArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 395
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let shareDetailViewController = ShareDetailViewController()
        shareDetailViewController.event = filteredArray[indexPath.row]
        navigationController?.pushViewController(shareDetailViewController, animated: true)
        
    }
    
}

// MARK: - UISearchBarDelegate
extension ShareViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        filter()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        headerView.hideSearchBar()
        searchBar.searchTextField.text = ""
        searchString = ""
        filter()
    }
    
}
