//
//  PlacesRequestFactory.swift
//  imlocal
//
//  Created by Denis on 12.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation
import Alamofire

protocol PlacesRequestFactory {
    func placesGet(userPoint: String, range: Int, page: Int, perPage: Int, completionHandler: @escaping (DataResponse<[PlacesResult]>) -> Void)
}


class PlacesRequest: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: SessionManager
    let queue: DispatchQueue?
    let baseUrl = URL(string: "https://atolserver.xyz/api/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: SessionManager,
        queue: DispatchQueue? = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension PlacesRequest: PlacesRequestFactory {
    func placesGet(userPoint: String, range: Int, page: Int, perPage: Int, completionHandler: @escaping (DataResponse<[PlacesResult]>) -> Void) {
        let requestModel = PlacesGet(baseUrl: baseUrl, userPoint: userPoint, range: range, page: page, perPage: perPage)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension PlacesRequest {
    struct PlacesGet: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "shop"
        
        let userPoint: String
        let range: Int
        let page: Int
        let perPage: Int
        var parameters: Parameters? {
            return [
                "userPoint": userPoint,
                "range": range,
                "page": page,
                "per-page": perPage
            ]
        }
    }
}
