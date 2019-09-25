//
//  AlamofireTracingAdapter.swift
//  swift-example-project
//
//  Copyright © 2019 Undefined Labs. All rights reserved.
//

/**
 * SCOPE
 * This is a helper class added to the original project.
 * It is used for adding http instrumentation easily to Alamofire requests.
 * If we use the session from this class instead of the default from Alamofire,
 * we will add http instrumentation automatically
 *
 * @see https://github.com/undefinedlabs/ios-agent#http-instrumentation
 */

import Alamofire
import Foundation
import ScopeAgent

class AlamofireTracing: RequestAdapter {
    static var session: SessionManager {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.adapter = AlamofireTracing()
        return sessionManager
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let urlRequest = SAURLSessionObserver.adapt(urlRequest)
        return urlRequest
    }
}
