//
//  PLacesModel.swift
//  imlocal
//
//  Created by Denis on 15.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation

class PlacesModel  {
    
    let requestFactory = RequestFactory()
    
    func getData(userPoint: String, range: Int, page: Int, perPage: Int, completion: @escaping ([PlacesResult]?) -> ()) {
        let places = requestFactory.makePlacesRequestFactory()
        places.placesGet(userPoint: userPoint, range: range, page: page, perPage: perPage) { response in
            switch response.result {
            case .success(let places):
                completion(places)
                print(places)
                print(response.request?.url as Any)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
