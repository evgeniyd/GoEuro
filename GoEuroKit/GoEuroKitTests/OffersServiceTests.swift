//
//  OffersServiceTests.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import XCTest
@testable import GoEuroKit
import Result

class OffersServiceTests: XCTestCase {
    var offerService = OffersService()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRequestable() {
        let asyncExpectation = expectation(description: "longRunningFunction")
        
        offerService.requestWith { res in
            print("\(res)")
            
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error, "Something went horribly wrong")
        }
    }
    
}
