//
//  BurgerCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 04.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class BurgerCell: UITableViewCell {
    
    private let cellLabel = UILabel()
    let cellIcon = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellLabel()
        setupIcon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellLabel() {
        let leading: CGFloat = 60
        let trailing: CGFloat = 10
        cellLabel.numberOfLines = 1
        cellLabel.textAlignment = .left
        cellLabel.font = .regularFont(size: 16)
        cellLabel.textColor = .imlocalMainColor
        contentView.addSubview(cellLabel)
        
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: leading).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -trailing).isActive = true
    }
    
    private func setupIcon() {
        let size: CGFloat = 25
        let leading: CGFloat = 19
        contentView.addSubview(cellIcon)
        
        cellIcon.translatesAutoresizingMaskIntoConstraints = false
        cellIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                          constant: leading).isActive = true
        cellIcon.widthAnchor.constraint(equalToConstant: size).isActive = true
        cellIcon.heightAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    func configure(_ title: String, _ image: UIImage) {
        cellLabel.text = title
        cellIcon.image = image
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = .white
        } else {
            contentView.backgroundColor = .imlocalBackgroundColor
        }
        
    }
    
}
