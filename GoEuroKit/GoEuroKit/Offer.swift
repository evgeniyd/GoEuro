//
//  Offer.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

////////////////////////////////////
// MARK: Offer Model -
////////////////////////////////////
public struct Offer {
    public var id: String
    public var logo: Logo
    public var price: Price
    public var departure: Date
    public var arrival: Date
    public var stops: Int8
}

////////////////////////////////////
// MARK: Supporting Models -
////////////////////////////////////

public struct Logo {
    public var url: URL
    public var dimension: Float
}

public struct Price {
    public var amount: Double
    public var currency: Currency
}

public enum Currency {
    case unspecified, euro
}
