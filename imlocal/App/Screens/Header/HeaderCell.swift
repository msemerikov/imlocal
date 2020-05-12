//
//  HeaderCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 31.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    static let reuseIdentifier = "HeaderCell"
    
//    private let cellView = UIView()
    private let cellLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellLabel()
        backgroundColor = .white
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            cellLabel.textColor = isSelected ? UIColor.white : UIColor.imlocalMainColor
            backgroundColor = isSelected ? UIColor.imlocalMainColor : UIColor.white
        }
    }
    
    private func setupCellLabel() {
        let hInset: CGFloat = 8
        let vInset: CGFloat = 1
        
        cellLabel.numberOfLines = 1
        cellLabel.textAlignment = .center
        cellLabel.font = .mediumFont(size: 14)
        cellLabel.textColor = .imlocalMainColor
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: vInset).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -vInset).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: hInset).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -hInset).isActive = true
    }
    
    func configure(_ title: String) {
        cellLabel.text = title
    }
    
}
