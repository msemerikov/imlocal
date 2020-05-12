//
//  ScreenType.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 07.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

enum ScreenType {
    case places
    case share
    case events
    
    var title: String {
        switch self {
        case .places: return "Места"
        case .share: return "Акции"
        case .events: return "События"
        }
    }
}
