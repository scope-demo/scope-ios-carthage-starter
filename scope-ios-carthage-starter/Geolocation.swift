//
//  Geolocation.swift
//  ScopeAgent-Reference
//
//  Copyright © 2019 Undefined Labs. All rights reserved.
//

/**
 * SCOPE
 *
 * Geolocation class has a method that calls a external service with HTTP.
 * ScopeAgent is imported here to integrate with the HTTP service with some custom code.
 * method getLocationWithAlamofire uses AlamofireTracing helper to automatically add Scope http headers instead of default Alamofire SessionManager
 * method getLocationWithURLSession uses SAURLSessionObserver class in Scope framework to append http headers to the Request
 */

import Alamofire
import CoreLocation
import Foundation
import ScopeAgent

class Geolocation {
    class func getLocationWithAlamofire(identifier: String, completion: @escaping ((CLLocation?) -> Void)) {
        var url = URL(string: "http://flask-example-project.codescope.com:8000/car/")!
        url.appendPathComponent(identifier)

        /**
         * SCOPE
         * Original code before intrumentation:
         * SessionManager.request(url).responseJSON { response in
         */
        AlamofireTracing.session.request(url).responseJSON { response in
            if let result = response.result.value,
                let JSON = result as? NSDictionary,
                let lat = JSON["lat"] as? Double,
                let lon = JSON["lon"] as? Double {
                let location = CLLocation(latitude: lat, longitude: lon)
                completion(location)
            } else {
                completion(nil)
            }
        }
    }

    class func getLocationWithURLSession(identifier: String, completion: @escaping ((CLLocation?) -> Void)) {
        var url = URL(string: "http://flask-example-project.codescope.com:8000/car/")!
        url.appendPathComponent(identifier)

        var request = URLRequest(url: url)

        /**
         * SCOPE
         * Add following line to add HTTP instrumentation. It modifies request headers as expected by Scope.
         */
        request = SAURLSessionObserver.adapt(request)
        /* SCOPE */

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data,
                error == nil,
                let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let lat = JSON["lat"] as? Double,
                let lon = JSON["lon"] as? Double {
                let location = CLLocation(latitude: lat, longitude: lon)
                completion(location)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

/**
 * SCOPE
 *
 * Identifiers struct has two identifiers to pass geolocation service, good_identifier should work correctly,
 * bad_identifier should produce a server failure because it is not a correct UUID
 */
struct Identifiers {
    static let good_identifier = "9E219725-490E-4509-A42D-D0388DF317D4"
    static let bad_identifier = "XE219725-490E-4509-A42D-D0388DF317D4"
}
