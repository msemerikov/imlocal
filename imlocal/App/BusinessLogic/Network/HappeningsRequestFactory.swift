//
//  HappeningsRequestFactory.swift
//  imlocal
//
//  Created by Denis on 13.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation
import Alamofire

protocol HappeningsRequestFactory {
    func happeningsGet(page: Int, perPage: Int, completionHandler: @escaping (DataResponse<[HappeningResult]>) -> Void)
}


class HappeningsRequest: AbstractRequestFactory {
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

extension HappeningsRequest: HappeningsRequestFactory {
    func happeningsGet(page: Int, perPage: Int, completionHandler: @escaping (DataResponse<[HappeningResult]>) -> Void) {
        let requestModel = HappeningsGet(baseUrl: baseUrl, page: page, perPage: perPage)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension HappeningsRequest {
    struct HappeningsGet: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "happenings"
        
        let page: Int
        let perPage: Int
        var parameters: Parameters? {
            return [
                "page": page,
                "per-page": perPage
            ]
        }
    }
}
