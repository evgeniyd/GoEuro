//
//  Bundle+Tests.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/24/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

fileprivate let testTargetBundleIdentifier = "com.goeuro.GoEuroKitTests"

extension Bundle {
    open class var test: Bundle {
        get {
            return Bundle.init(identifier: testTargetBundleIdentifier)!
        }
    }
    
    open func path(forJSONResource name: String?) -> String? {
        return self.path(forResource: name, ofType: "json")
    }
}

