//
//  Shop.swift
//  imlocal
//
//  Created by Denis on 12.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

struct Shop: Codable{
    let shopShortName: String?
    let shopAddress: ShopAddress?
    let shopPhotos: [ShopPhotos]
    let shopAvgRating: String?
}
