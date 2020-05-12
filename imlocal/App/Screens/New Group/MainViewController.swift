//
//  MainViewController.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 18.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import MapKit
import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Constants and variables
    private let scrollView = UIScrollView()
    private let logoImage = UIImageView()
    private let logoLabel = UILabel()
    private let mainButton = UIButton()
    private let businessButton = UIButton()
    private let loginButton = UIButton()
    private let titleLabel = UILabel()
    private let locationLabel = UILabel()
    private let locationStackView = UIView()
    private let locationImage = UIImageView()
    private let locationTitle = UILabel()
    private let locationArrowImage = UIImageView()
    private let radiusLabel = UILabel()
    private let radiusStackView = UIView()
    private let radiusImage = UIImageView()
    private let radiusSlider = UISlider()
    private let startButton = UIButton()
    
    var userPoint: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupLogoImage()
        setupLogoLabel()
        setupLoginButton()
        setupBusinessButton()
        setupMainButton()
        setupTitleLabel()
        setupLocationLabel()
        setupLocationStackView()
        setupLocationImage()
        setupLocationArrowImage()
        setupLocationTitle()
        setupRadiusLabel()
        setupRadiusStackView()
        setupRadiusImage()
        setupRadiusSlider()
        setupStartButton()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(locationTapped))
        locationStackView.isUserInteractionEnabled = true
        locationStackView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
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
    
    private func setupLogoImage() {
        let top: CGFloat = 14
        let leading: CGFloat = 15
        let width: CGFloat = 30
        let logoImageName = "Vector"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        
        logoImage.image = image
        scrollView.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                       constant: top).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                           constant: leading).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupLogoLabel() {
        let leading: CGFloat = 6
        let width: CGFloat = 93
        let height: CGFloat = 23
        
        logoLabel.font = .titleFont(size: 18)
        logoLabel.textColor = .imlocalMainColor
        logoLabel.textAlignment = .left
        logoLabel.numberOfLines = 1
        logoLabel.text = "i'm local"
        scrollView.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor).isActive = true
        logoLabel.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor,
                                            constant: leading).isActive = true
        logoLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        logoLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLoginButton() {
        let trailing: CGFloat = 13
        let width: CGFloat = 34
        let height: CGFloat = 18
        
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.setTitle("Вход", for: .normal)
        loginButton.setTitleColor(.imlocalLightGray, for: .normal)
        loginButton.titleLabel?.font = .mediumFont(size: 14)
        loginButton.contentHorizontalAlignment = .center
        loginButton.contentVerticalAlignment = .center
        scrollView.addSubview(loginButton)
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: Screen.width - trailing).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupBusinessButton() {
        let trailing: CGFloat = 15
        let width: CGFloat = 54
        let height: CGFloat = 18
        
        businessButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        businessButton.setTitle("Бизнесу", for: .normal)
        businessButton.setTitleColor(.imlocalLightGray, for: .normal)
        businessButton.titleLabel?.font = .mediumFont(size: 14)
        businessButton.contentHorizontalAlignment = .center
        businessButton.contentVerticalAlignment = .center
        scrollView.addSubview(businessButton)
        
        businessButton.translatesAutoresizingMaskIntoConstraints = false
        businessButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor).isActive = true
        businessButton.trailingAnchor.constraint(equalTo: loginButton.leadingAnchor,
                                              constant: -trailing).isActive = true
        businessButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        businessButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupMainButton() {
        let trailing: CGFloat = 15
        let width: CGFloat = 54
        let height: CGFloat = 18
        
        mainButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        mainButton.setTitle("Главная", for: .normal)
        mainButton.setTitleColor(.imlocalMainColor, for: .normal)
        mainButton.titleLabel?.font = .mediumFont(size: 14)
        mainButton.contentHorizontalAlignment = .center
        mainButton.contentVerticalAlignment = .center
        scrollView.addSubview(mainButton)
        
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        mainButton.centerYAnchor.constraint(equalTo: logoImage.centerYAnchor).isActive = true
        mainButton.trailingAnchor.constraint(equalTo: businessButton.leadingAnchor,
                                              constant: -trailing).isActive = true
        mainButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupTitleLabel() {
        let top: CGFloat = 41
        let leading: CGFloat = 15
        let width: CGFloat = Screen.width - (leading * 2)
        let height: CGFloat = 153
        
        titleLabel.font = .titleFont(size: 36)
        titleLabel.textColor = .imlocalMainColor
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.text = "I’m local – ваш гид по местам в округе"
        scrollView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor,
                                        constant: top).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLocationLabel() {
        let top: CGFloat = 17
        let leading: CGFloat = 15
        let width: CGFloat = Screen.width - (leading * 2)
        let height: CGFloat = 19
        
        locationLabel.font = .mediumFont(size: 16)
        locationLabel.textColor = .black
        locationLabel.textAlignment = .left
        locationLabel.numberOfLines = 1
        locationLabel.text = "Выберите местоположение"
        scrollView.addSubview(locationLabel)
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                        constant: top).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        locationLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLocationStackView() {
        let top: CGFloat = 16
        let leading: CGFloat = 15
        let width: CGFloat = Screen.width - (leading * 2)
        let height: CGFloat = 50
        
        locationStackView.backgroundColor = .white
        locationStackView.layer.cornerRadius = 5
        locationStackView.layer.masksToBounds = false
        locationStackView.layer.shadowColor = UIColor.shadowColor.cgColor
        locationStackView.layer.shadowOpacity = 1
        locationStackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        locationStackView.layer.shadowRadius = 10
        scrollView.addSubview(locationStackView)
        
        locationStackView.translatesAutoresizingMaskIntoConstraints = false
        locationStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: leading).isActive = true
        locationStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor,
                                               constant: top).isActive = true
        locationStackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        locationStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLocationImage() {
        let leading: CGFloat = 12
        let width: CGFloat = 20
        let logoImageName = "Building"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        
        locationImage.image = image
        locationStackView.addSubview(locationImage)
        
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        locationImage.centerYAnchor.constraint(equalTo: locationStackView.centerYAnchor).isActive = true
        locationImage.leadingAnchor.constraint(equalTo: locationStackView.leadingAnchor,
                                               constant: leading).isActive = true
        locationImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        locationImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupLocationArrowImage() {
        let trailing: CGFloat = 12
        let width: CGFloat = 6
        let height: CGFloat = 11
        let logoImageName = "ArrowRight"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        
        locationArrowImage.image = image
        locationStackView.addSubview(locationArrowImage)
        
        locationArrowImage.translatesAutoresizingMaskIntoConstraints = false
        locationArrowImage.centerYAnchor.constraint(equalTo: locationStackView.centerYAnchor).isActive = true
        locationArrowImage.leadingAnchor.constraint(equalTo: locationStackView.trailingAnchor,
                                                    constant: -trailing).isActive = true
        locationArrowImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        locationArrowImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupLocationTitle() {
        let leading: CGFloat = 14
        let height: CGFloat = 15
        
        locationTitle.font = .regularFont(size: 14)
        locationTitle.textColor = .imlocalLightGray
        locationTitle.textAlignment = .left
        locationTitle.numberOfLines = 1
        locationTitle.text = "Не выбрано"
        locationStackView.addSubview(locationTitle)
        
        locationTitle.translatesAutoresizingMaskIntoConstraints = false
        locationTitle.centerYAnchor.constraint(equalTo: locationStackView.centerYAnchor).isActive = true
        locationTitle.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor,
                                               constant: leading).isActive = true
        locationTitle.trailingAnchor.constraint(equalTo: locationArrowImage.leadingAnchor,
                                                constant: -leading).isActive = true
        locationTitle.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRadiusLabel() {
        let top: CGFloat = 15
        let leading: CGFloat = 15
        let width: CGFloat = Screen.width - (leading * 2)
        let height: CGFloat = 19
        
        radiusLabel.font = .mediumFont(size: 16)
        radiusLabel.textColor = .black
        radiusLabel.textAlignment = .left
        radiusLabel.numberOfLines = 1
        radiusLabel.colorString(text: "Радиус поиска 100 м", coloredText: "100 м", color: .imlocalMainColor)
        scrollView.addSubview(radiusLabel)
        
        radiusLabel.translatesAutoresizingMaskIntoConstraints = false
        radiusLabel.topAnchor.constraint(equalTo: locationStackView.bottomAnchor,
                                        constant: top).isActive = true
        radiusLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                            constant: leading).isActive = true
        radiusLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        radiusLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRadiusStackView() {
        let top: CGFloat = 16
        let leading: CGFloat = 15
        let width: CGFloat = Screen.width - (leading * 2)
        let height: CGFloat = 50
        
        radiusStackView.backgroundColor = .white
        radiusStackView.layer.cornerRadius = 5
        radiusStackView.layer.masksToBounds = false
        radiusStackView.layer.shadowColor = UIColor.shadowColor.cgColor
        radiusStackView.layer.shadowOpacity = 1
        radiusStackView.layer.shadowOffset = CGSize(width: 0, height: 1)
        radiusStackView.layer.shadowRadius = 10
        scrollView.addSubview(radiusStackView)
        
        radiusStackView.translatesAutoresizingMaskIntoConstraints = false
        radiusStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                   constant: leading).isActive = true
        radiusStackView.topAnchor.constraint(equalTo: radiusLabel.bottomAnchor,
                                               constant: top).isActive = true
        radiusStackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        radiusStackView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupRadiusImage() {
        let leading: CGFloat = 12
        let width: CGFloat = 20
        let logoImageName = "Point"
        guard let image = UIImage(named: logoImageName) else {
            assertionFailure("Missing ​​\(logoImageName) asset")
            return
        }
        
        radiusImage.image = image
        radiusStackView.addSubview(radiusImage)
        
        radiusImage.translatesAutoresizingMaskIntoConstraints = false
        radiusImage.centerYAnchor.constraint(equalTo: radiusStackView.centerYAnchor).isActive = true
        radiusImage.leadingAnchor.constraint(equalTo: radiusStackView.leadingAnchor,
                                               constant: leading).isActive = true
        radiusImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        radiusImage.heightAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func setupRadiusSlider() {
        let leading: CGFloat = 15
        let trailing: CGFloat = 23
        radiusSlider.thumbTintColor = .imlocalMainColor
        radiusSlider.tintColor = .imlocalMainColor
        
        radiusSlider.minimumValue = 1
        radiusSlider.maximumValue = 100
        radiusSlider.isContinuous = true
        radiusSlider.addTarget(self, action: #selector(sliderValueDidChange), for: .valueChanged)
        radiusStackView.addSubview(radiusSlider)
        
        radiusSlider.translatesAutoresizingMaskIntoConstraints = false
        radiusSlider.centerYAnchor.constraint(equalTo: radiusStackView.centerYAnchor).isActive = true
        radiusSlider.leadingAnchor.constraint(equalTo: radiusImage.trailingAnchor,
                                               constant: leading).isActive = true
        radiusSlider.trailingAnchor.constraint(equalTo: radiusStackView.trailingAnchor,
                                               constant: -trailing).isActive = true
        radiusSlider.heightAnchor.constraint(equalToConstant: 13).isActive = true
    }
    
    private func setupStartButton() {
        let top: CGFloat = 15
        let leading: CGFloat = 15
        let width: CGFloat = Screen.width - (leading * 2)
        let height: CGFloat = 40
        
        startButton.addTarget(self, action: #selector(startButtonPressed), for: .touchUpInside)
        startButton.backgroundColor = .imlocalMainColor
        startButton.layer.cornerRadius = 5
        startButton.setTitle("Начать", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = .mediumFont(size: 14)
        startButton.contentHorizontalAlignment = .center
        startButton.contentVerticalAlignment = .center
        scrollView.addSubview(startButton)
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.topAnchor.constraint(equalTo: radiusStackView.bottomAnchor,
                                         constant: top).isActive = true
        startButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                              constant: leading).isActive = true
        startButton.widthAnchor.constraint(equalToConstant: width).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    @objc private func loginButtonPressed() {
        
    }
    
    @objc private func startButtonPressed() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController!)
        mapCoordinator.start(location: userPoint, radius: Int(radiusSlider.value * 100), delegate: self)
    }
    
    @objc private func locationTapped() {
        let mapCoordinator = MapCoordinator(navigationController: navigationController!)
        mapCoordinator.startSetupLocation(location: userPoint, radius: Int(radiusSlider.value * 100), delegate: self)
    }
    
    @objc private func sliderValueDidChange(_ sender: UISlider!) {
        let text = "Радиус поиска \(Int(sender.value) * 100) м"
        let coloredText = "\(Int(sender.value) * 100) м"
        radiusLabel.colorString(text: text, coloredText: coloredText, color: .imlocalMainColor)
    }
    
}

// MARK: - MapViewDelegate
extension MainViewController: MapViewDelegate {
    
    func setLocality(_ location: String, coordinate: CLLocationCoordinate2D) {
        locationTitle.text = location
        userPoint = coordinate
    }
    
}
