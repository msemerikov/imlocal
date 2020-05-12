//
//  UILabel+Ext.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 07.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

extension UILabel {
    
    func colorString(text: String, coloredText: String, color: UIColor? = .red) {
        
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: coloredText)
        attributedString.setAttributes([NSAttributedString.Key.foregroundColor: color as Any],
                                       range: range)
        self.attributedText = attributedString
    }
    
}
