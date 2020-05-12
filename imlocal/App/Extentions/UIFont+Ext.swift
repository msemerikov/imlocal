//
//  UIFont+Ext.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 31.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func titleFont(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "YesevaOne", size: size) else {
            fatalError("""
                Failed to load the "YesevaOne" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func regularFont(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "SFProDisplay-Regular", size: size) else {
            fatalError("""
                Failed to load the "SFProDisplay-Regular" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func mediumFont(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "SFProDisplay-Medium", size: size) else {
            fatalError("""
                Failed to load the "SFProDisplay-Medium" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
    class func boldFont(size: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: "SFProDisplay-Bold", size: size) else {
            fatalError("""
                Failed to load the "SFProDisplay-Bold" font.
                Make sure the font file is included in the project and the font name is spelled correctly.
                """
            )
        }
        return customFont
    }
    
}
