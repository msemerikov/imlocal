//
//  AllButtonsForScrollView.swift
//  imlocal
//
//  Created by Denis on 27.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

enum ButtonsForScrollView: Int {
    case food
    case shild
    case sport
    case beauty
    case purchases
    case all
    
    static let allButtonsForScrollView: [ButtonsForScrollView] = [food, shild, sport, beauty, purchases, all]

    var title: String {
        switch self {
        case .food: return "Еда"
        case .shild: return "Дети"
        case .sport: return "Спорт"
        case .beauty: return "Красота"
        case .purchases: return "Покупки"
        case .all: return "Все"
        }
    }
}
