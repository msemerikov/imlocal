//
//  PlaceEventCell.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 14.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

class PlaceEventCell: UICollectionViewCell {
    
    static let reuseIdentifier = "PlaceEventCell"
    
    private let eventImage = UIImageView()
    private let eventNameLabel = UILabel()
    private let eventDescLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEventImage()
        setupEventNameLabel()
        setupEventDescLabel()
        backgroundColor = .white
//        layer.cornerRadius = frame.height / 2
//        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var isSelected: Bool {
//        didSet {
//            cellLabel.textColor = isSelected ? UIColor.white : UIColor.imlocalMainColor
//            backgroundColor = isSelected ? UIColor.imlocalMainColor : UIColor.white
//        }
//    }
    
    private func setupEventImage() {
        let height: CGFloat = 124
        contentView.addSubview(eventImage)
        eventImage.backgroundColor = .imlocalMainColor
        eventImage.contentMode = .scaleAspectFill
        eventImage.layer.cornerRadius = 5
        eventImage.clipsToBounds = true
        
        eventImage.translatesAutoresizingMaskIntoConstraints = false
        eventImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        eventImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        eventImage.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        eventImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    private func setupEventNameLabel() {
        let leading: CGFloat = 6
        
        eventNameLabel.numberOfLines = 0
        eventNameLabel.textAlignment = .center
        eventNameLabel.font = .mediumFont(size: 16)
        eventNameLabel.textColor = .white
        contentView.addSubview(eventNameLabel)
        
        eventNameLabel.translatesAutoresizingMaskIntoConstraints = false
        eventNameLabel.bottomAnchor.constraint(equalTo: eventImage.bottomAnchor,
                                          constant: -leading).isActive = true
        eventNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: leading).isActive = true
        eventNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -leading).isActive = true
    }
    
    private func setupEventDescLabel() {
        let leading: CGFloat = 9
        let top: CGFloat = 5
        
        eventDescLabel.numberOfLines = 0
        eventDescLabel.textAlignment = .center
        eventDescLabel.font = .regularFont(size: 12)
        eventDescLabel.textColor = .black
        contentView.addSubview(eventDescLabel)
        
        eventDescLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDescLabel.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor,
                                            constant: top).isActive = true
        eventDescLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -leading).isActive = true
        eventDescLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: leading).isActive = true
        eventDescLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -leading).isActive = true
    }
    
    func configure(_ event: EventsResult?) {
        let imageEvent = event?.eventPhotos[0].eventPhoto
        eventImage.downloaded(from: "https://atolserver.xyz/img/eventPhoto/\(imageEvent ?? "")")
        eventNameLabel.text = event?.title
        eventDescLabel.text = event?.shortDesc
    }
    
}
