//
//  EventsRequestFactory.swift
//  imlocal
//
//  Created by Denis on 13.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import Foundation
import Alamofire

protocol EventsRequestFactory {
    func eventsGet(page: Int, perPage: Int, completionHandler: @escaping (DataResponse<[EventsResult]>) -> Void)
}

class EventsRequest: AbstractRequestFactory {
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

extension EventsRequest: EventsRequestFactory {
    func eventsGet(page: Int, perPage: Int, completionHandler: @escaping (DataResponse<[EventsResult]>) -> Void) {
        let requestModel = EventsGet(baseUrl: baseUrl, page: page, perPage: perPage)
        self.request(request: requestModel, completionHandler: completionHandler)
    }

}

extension EventsRequest {
    struct EventsGet: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "events"
        
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
