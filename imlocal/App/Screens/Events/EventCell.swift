//
//  EventCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 06.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    private let backgroundImage = UIImageView()
    private let priceLabel = UILabel()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let separatorView = UIView()
    private var priceWidth: CGFloat = 0
    private let separatorHeight: CGFloat = 15
    private var constr: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBackgroundImage()
        setupPriceLabel()
        setupTitleLabel()
        setupDateLabel()
        setupSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Установка фонового изображения
    private func setupBackgroundImage() {
        contentView.addSubview(backgroundImage)
        backgroundImage.backgroundColor = .red
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.layer.cornerRadius = 5
        backgroundImage.clipsToBounds = true
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                constant: -separatorHeight).isActive = true
    }
    
    /// Установка надписи со стоимостью
    private func setupPriceLabel() {
        let height: CGFloat = 24
        let indent: CGFloat = 10
        
        priceLabel.numberOfLines = 1
        priceLabel.textAlignment = .center
        priceLabel.font = .systemFont(ofSize: 14)
        priceLabel.textColor = .white
        priceLabel.backgroundColor = .imlocalMainColor
        priceLabel.layer.cornerRadius = 5
        priceLabel.clipsToBounds = true
        contentView.addSubview(priceLabel)
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: -indent).isActive = true
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: indent).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// Установка названия события
    private func setupTitleLabel() {
        let bottom: CGFloat = 43
        let indent: CGFloat = 10
        
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .white
        contentView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                            constant: indent).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                             constant: -indent).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                           constant: -bottom).isActive = true
    }
    
    /// Установка времени начала события
    private func setupDateLabel() {
        let bottom: CGFloat = 23
        let indent: CGFloat = 10
        let height: CGFloat = 15
        
        dateLabel.textAlignment = .left
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .white
        contentView.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: indent).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -indent).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -bottom).isActive = true
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
    /// - Parameters:
    ///   - image: название изображения
    ///   - price: стоимость события
    ///   - title: название события
    ///   - date: дата начала события
    func configure(image: String, price: String, title: String, date: String) {
        backgroundImage.downloaded(from: "https://atolserver.xyz/img/happeningPhoto/\(image)")
        priceLabel.text = getPriceString(price: price)
        titleLabel.text = title
        dateLabel.text = date
        constr?.isActive = false
        priceWidth = getPriceString(price: price).width(withConstrainedHeight: 12, font: .systemFont(ofSize: 14)) + 8
        constr = priceLabel.widthAnchor.constraint(equalToConstant: priceWidth)
        constr?.isActive = true
    }
    
    /// Преобразование формата стоимости события
    /// - Parameter price: стоимость
    private func getPriceString(price: String) -> String {
        return price == "0" ? "Free" : "\(price) ₽"
    }
    
}
