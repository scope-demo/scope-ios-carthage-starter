//
//  scope_ios_carthage_starterTests.swift
//  scope-ios-carthage-starterTests
//
//  Created by Ignacio Bonafonte on 25/09/2019.
//  Copyright © 2019 Undefined Labs. All rights reserved.
//

@testable import scope_ios_carthage_starter
import XCTest
import os

class scope_ios_carthage_starterTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     * SCOPE
     * Example of a passing test
     */
    func testPass() {
        XCTAssert(true)
    }

    /**
     * SCOPE
     * This test shows how Scope captures networking activity initiated with Alamofire without neededing any custom code
     */
    func testNetworkingAlamofire() {
        let expec = expectation(description: "testNetworkingAlamofire")

        Networking.alamofireExample {
            expec.fulfill()
        }

        waitForExpectations(timeout: 30) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    /**
     * SCOPE
     * This test shows how Scope captures networking activity initiated with default URLSession without neededing any custom code
     */
    func testNetworkingURLSession() {
        let expec = expectation(description: "testNetworkingAlamofire")

        Networking.urlSessionExample {
            expec.fulfill()
        }

        waitForExpectations(timeout: 30) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    /**
     * SCOPE
     * This test shows how NSLog, os_log or print messages shows in Scope results without code changes
     */
    func testStandardLogging() {
        NSLog("Message logged with NSLog(). It uses stderr stream")
        print("Message logged with print(). It uses stdout stream")
        os_log("Message logged with os_log(). It uses stderr stream")
        XCTAssert(true)
    }
}
