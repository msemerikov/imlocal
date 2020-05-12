//
//  EventsViewController.swift
//  imlocal
//
//  Created by Denis on 19.12.2019.
//  Copyright © 2019 Denis. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController, Storyboarded {
    
    // MARK: - Constants and variables
    private let requestFactory = RequestFactory()
    private let headerView = HeaderView(type: .events)
    private var burgerMenu = BurgerMenuView()
    private let stackView = UIView()
    private let dateLabel = UILabel()
    private let dateButton = UIButton()
    private let freeLabel = UILabel()
    private let freeButton = UIButton()
    private var tableView = UITableView()
    private var happeningsArray: [HappeningResult] = []
    private var filteredArray: [HappeningResult] = []
    private var searchString = ""
    
    // MARK: - Lifecycle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        getHappenings()
        setupHeaderView()
        setupStackView()
        setupDateLabel()
        setupDateButton()
        setupFreeButton()
        setupFreeLabel()
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
    private func getHappenings() {
        let happening = requestFactory.makeHappeningsRequestFactory()
        happening.happeningsGet(page: 1, perPage: 10) { response in
            switch response.result {
            case .success(let happening):
                self.happeningsArray = happening
                self.filteredArray = happening
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
        if freeButton.isSelected {
            
            guard !searchString.isEmpty else {
                filteredArray = happeningsArray.filter {
                    $0.price == "0"
                }
                reloadTableView()
                return
            }
            
            filteredArray = happeningsArray.filter({
                $0.price == "0" &&
                    ($0.title?.lowercased().contains(searchString.lowercased()))!
            })
            
        } else {
            guard !searchString.isEmpty else {
                filteredArray = happeningsArray
                reloadTableView()
                return
            }
            filteredArray = happeningsArray.filter({
                ($0.title?.lowercased().contains(searchString.lowercased()))!
            })
        }
        
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
    
    /// Установка надписи дата
    private func setupDateLabel() {
        let leading: CGFloat = 15
        let height: CGFloat = 17
        let width: CGFloat = 35
        
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        dateLabel.font = .regularFont(size: 14)
        dateLabel.textColor = .imlocalLightGray
        dateLabel.text = "Дата:"
        stackView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
                                           constant: leading).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка кнопки выборы даты
    private func setupDateButton() {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.mediumFont(size: 14),
            .foregroundColor: UIColor.imlocalMainColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "с 18.07 по 31.08",
                                                        attributes: attributes)
        let leading: CGFloat = 1
        let width: CGFloat = 110
        let height: CGFloat = 17
        
        dateButton.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
        dateButton.setAttributedTitle(attributeString, for: .normal)
        dateButton.contentVerticalAlignment = .center
        dateButton.contentHorizontalAlignment = .left
        stackView.addSubview(dateButton)
        
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        dateButton.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor,
                                            constant: leading).isActive = true
        dateButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        dateButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка надписи для переключателя стоимости
    private func setupFreeLabel() {
        let trailing: CGFloat = 10
        let height: CGFloat = 17
        let width: CGFloat = 90
        
        freeLabel.numberOfLines = 1
        freeLabel.textAlignment = .left
        freeLabel.font = .mediumFont(size: 14)
        freeLabel.textColor = .imlocalMainColor
        freeLabel.text = "Бесплатные"
        stackView.addSubview(freeLabel)
        
        freeLabel.translatesAutoresizingMaskIntoConstraints = false
        freeLabel.trailingAnchor.constraint(equalTo: freeButton.leadingAnchor,
                                            constant: trailing).isActive = true
        freeLabel.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        freeLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        freeLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка переключателя стоимости событий
    private func setupFreeButton() {
        let trailing: CGFloat = 15
        let height: CGFloat = 24
        let width: CGFloat = 38
        
        freeButton.addTarget(self, action: #selector(freeButtonPressed), for: .touchUpInside)
        freeButton.setImage(UIImage(named: "Switch"), for: .normal)
        freeButton.setImage(UIImage(named: "SwitchActive"), for: .selected)
        freeButton.contentVerticalAlignment = .center
        freeButton.contentHorizontalAlignment = .center
        stackView.addSubview(freeButton)
        
        freeButton.translatesAutoresizingMaskIntoConstraints = false
        freeButton.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        freeButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
                                             constant: -trailing).isActive = true
        freeButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        freeButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка таблицы событий
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
        tableView.register(FooterCell.self, forCellReuseIdentifier: "FooterCell")
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 216).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: - Buttons methods
    /// Выбор даты для фильтрации событий
    @objc private func dateButtonPressed() {
        print("Выбор даты")
    }
    
    /// Фильтрация событий по стоимости (бесплатные/все)
    @objc private func freeButtonPressed() {
        freeButton.isSelected = !freeButton.isSelected
        filter()
    }
        
}

// MARK: - HeaderViewDelegate
extension EventsViewController: HeaderViewDelegate {
    
    /// Показ "бургер" меню
    func showBurgerMenu() {
        let width = view.frame.width
        burgerMenu.isHidden = false
        
        UIView.animate(withDuration: 0.5) {
            self.burgerMenu.frame.origin.x += width * 0.6
        }
    }
    
}

// MARK: - BurgerMenuViewDelegate
extension EventsViewController: BurgerMenuViewDelegate {
    
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
extension EventsViewController: UITableViewDelegate { }

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count + 1
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case filteredArray.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell",
                                                           for: indexPath) as? FooterCell
                else { return UITableViewCell() }
            
            cell.configure(type: .events)
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell",
                                                           for: indexPath) as? EventCell
                else { return UITableViewCell() }
            
            cell.configure(filteredArray[indexPath.row])
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case filteredArray.count:
            return 400
        default:
            return 150
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case filteredArray.count:
            break
        default:
            let eventViewController = EventViewController()
            eventViewController.event = filteredArray[indexPath.row]
            navigationController?.pushViewController(eventViewController, animated: true)
        }
        
    }
    
}

// MARK: - UISearchBarDelegate
extension EventsViewController: UISearchBarDelegate {
    
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
