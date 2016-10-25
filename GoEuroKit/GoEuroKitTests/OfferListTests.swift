//
//  OfferListTests.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/24/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import XCTest
import Unbox
@testable import GoEuroKit

class OfferListTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testUnboxFromData() {
        do {
            let data = try Data(contentsOfJSONFile: "OfferListTests")
            
            do {
                let offerList: OfferList = try unbox(data: data)
                XCTAssertNotNil(offerList)
                XCTAssertEqual(30, offerList.count)
            } catch let unboxError {
                XCTAssert(false, unboxError.localizedDescription)
            }
        }
        catch let dataError {
            XCTAssert(false, dataError.localizedDescription)
        }
    }
}
