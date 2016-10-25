//
//  DateFormatter+GoEuroKitTests.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/24/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import XCTest
@testable import GoEuroKit

class DateFormatter_GoEuroKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFormat() {
        let formatter = DateFormatter.goEuroDateFormatter()
        
        let testDate01 = formatter.date(from: "1:23")
        XCTAssert((testDate01) != nil)
        
        let testDate02 = formatter.date(from: "19:55")
        XCTAssert((testDate02) != nil)
    }
}
