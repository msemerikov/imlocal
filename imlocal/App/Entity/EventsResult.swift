//
//  EventsResult.swift
//  imlocal
//
//  Created by Denis on 13.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

struct EventsResult: Codable {
    let id: Int?
    let active: Int?
    let isEventTop: Int?
    let eventOwnerId: Int?
    let eventTypeId: Int?
    let title: String?
    let shortDesc: String?
    let fullDesc: String?
    let begin: String?
    let end: String?
    let creatorId: Int?
    let eventPhotos: [EventPhotos]
    let shop: Shop
}
