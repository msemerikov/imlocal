//
//  UIViewController+Ext.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 14.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupToHideKeyboardOnTapOnView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
