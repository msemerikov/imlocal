//
//  AbstractErrorParser.swift
//  imlocal
//
//  Created by Denis on 12.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
