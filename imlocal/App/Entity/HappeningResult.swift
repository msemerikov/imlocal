//
//  HappeningsResult.swift
//  imlocal
//
//  Created by Denis on 13.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

struct HappeningResult: Codable {
    let id: Int?
    let shopId: Int?
    let creatorId: Int?
    let title: String?
    let description: String?
    let address: String?
    let price: String
    let begin: String?
    let createdOn: String?
    let updatedOn: String?
    let happeningTypeId: Int?
    let latitude: String?
    let longitude: String?
    let end: String?
    let active:Int?
    let happeningPhotos: [HappeningPhotos]?
}
