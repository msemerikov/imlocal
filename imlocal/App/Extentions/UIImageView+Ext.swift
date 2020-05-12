//
//  UIImageView+Ext.swift
//  imlocal
//
//  Created by Mikhail Semerikov on 06.02.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: ":/-.")
        guard let escapedString = link.addingPercentEncoding(withAllowedCharacters: allowed),
            let url = URL(string: escapedString) else {
            print("Bad URL \(link)")
            return
        }
 
        downloaded(from: url, contentMode: mode)
    }
    
}
