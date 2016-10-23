//
//  Response.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

////////////////////////////////////
// MARK: Model -
////////////////////////////////////

public struct Response {
    public var data: [Offer]
}

////////////////////////////////////
// MARK: Convenience methods -
////////////////////////////////////

extension Response {
    public var zeroItems: Bool {
        get {
            return (self.data.count == 0)
        }
    }
}
