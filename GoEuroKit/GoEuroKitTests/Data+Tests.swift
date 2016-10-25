//
//  Data+Tests.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/24/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

extension Data {
    public init(contentsOfJSONFile filename: String) throws {
        guard let path = Bundle.test.path(forJSONResource: filename) else {
            throw CocoaError(.fileNoSuchFile)
        }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        
        self = data
    }
}
