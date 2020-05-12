//
//  Screen.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 08.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

struct Screen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var statusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
}
