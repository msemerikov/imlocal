//
//  ShopAddress.swift
//  imlocal
//
//  Created by Denis on 12.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

struct ShopAddress: Codable {
    let id: Int?
    let city: String?
    let street: String?
    let houseNumber: String?
    let housing: String?
    let building: String?
    let latitude: Double?
    let longitude: Double?
}
