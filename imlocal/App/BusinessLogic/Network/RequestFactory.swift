//
//  RequestFactory.swift
//  imlocal
//
//  Created by Denis on 12.01.2020.
//  Copyright © 2020 Denis. All rights reserved.
//

import UIKit

import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makePlacesRequestFactory() -> PlacesRequestFactory {
        let errorParser = makeErrorParser()
        return PlacesRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeEventsRequestFactory() -> EventsRequestFactory {
        let errorParser = makeErrorParser()
        return EventsRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }
    
    func makeHappeningsRequestFactory() -> HappeningsRequestFactory {
        let errorParser = makeErrorParser()
        return HappeningsRequest(errorParser: errorParser, sessionManager: commonSessionManager, queue: sessionQueue)
    }

    
}
