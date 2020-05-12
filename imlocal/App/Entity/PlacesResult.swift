//
//  PlacesStruct.swift
//  imlocal
//
//  Created by Denis on 12.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

struct PlacesResult: Codable {
    let shopId: Int?
    let creatorId: Int?
    let shopActive: Int?
    let shopShortName: String?
    let shopFullName: String?
    let shopTypeId: Int?
    let shopPhone: String?
    let shopWeb: String?
    let shopAddressId: Int?
    let shopCostMin: String?
    let shopCostMax: String?
    let shopMiddleCost: String?
    let shopWorkTime: String?
    let shopAgregator: String?
    let shopStatusId: Int?
    let shopShortDescription: String?
    let shopFullDescription: String?
    let shopRating: Int?
    let shopLinkPdf: String?
    let isItFar: String?
    let shopPhotos: [ShopPhotos]?
    let events: [EventsResult]?
    let shopAddress: ShopAddress?
    let happenings: [HappeningResult]?
    let shopAvgRating: String?
    let distance: Int?
}

