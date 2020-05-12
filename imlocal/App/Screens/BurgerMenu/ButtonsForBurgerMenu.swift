//
//  ButtonsForBurgerMenu.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 05.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

enum ButtonsForBurgerMenu: Int {
    case user
    case favourites
    case help
    case business
    case exit
    
    var title: String {
        switch self {
        case .user: return "Вход*"
        case .favourites: return "Избранное"
        case .help: return "Помощь"
        case .business: return "Бизнесу"
        case .exit: return "Выход"
        }
    }
    
    var image: String {
        switch self {
        case .user: return "User"
        case .favourites: return "Favourites"
        case .help: return "Help"
        case .business: return "Business"
        case .exit: return "Exit"
        }
    }
}
