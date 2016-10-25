//
//  Offer.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation
import Unbox

////////////////////////////////////
// MARK: Offer Model -
////////////////////////////////////
public struct Offer {
    public var id: String
    public var logo: Logo
    public var price: Price
    public var departure: Date
    public var arrival: Date
    public var stops: Int // Ideally, has to be Int8, but parser does not support the transfor to the type
}

////////////////////////////////////
// MARK: Supporting Models -
////////////////////////////////////

public struct Logo {
    public var url: URL
    public var rawValue: String
    public var dimension: UInt
}

public struct Price {
    public var amount: Double
    public var currency: Currency
}

public enum Currency {
    case unspecified, euro
    
    public var code: String {
        switch self {
        case .euro:
            return "EUR"
        default:
            return "<unknown>"
        }
    }
}

////////////////////////////////////
// MARK: CustomDebugStringConvertible extension -
////////////////////////////////////

extension Offer: CustomDebugStringConvertible {
    public var debugDescription: String {
        get {
            return "\n<GoEuroKit.Offer>:\nid: \(self.id)\nlogo: \(self.logo.url.absoluteString)\nprice: \(self.price.amount)\ndeparture: \(self.departure)\narrival: \(self.arrival)\nstops: \(self.stops)\n"
        }
    }
}

////////////////////////////////////
// MARK: Unboxable extension -
////////////////////////////////////

private struct Static {
    static let dateFormatter : DateFormatter = {
        let formatter = DateFormatter.goEuroDateFormatter()
        return formatter
    }()
}


extension Offer: Unboxable {
    public init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "id")
        self.logo = try unboxer.unbox(key: "provider_logo")
        self.price = try unboxer.unbox(key: "price_in_euros")
        self.departure = try unboxer.unbox(key: "departure_time", formatter: Static.dateFormatter)
        self.arrival = try unboxer.unbox(key: "arrival_time", formatter: Static.dateFormatter)
        self.stops = try unboxer.unbox(key: "number_of_stops")
    }
}

extension Logo: UnboxableByTransform {
    public typealias UnboxRawValue = String
    
    init?(imagePath: String) {
        self.dimension = 63
        self.rawValue = imagePath
        let imagePath = self.rawValue.replacingOccurrences(of: "{size}", with: "\(self.dimension)")
        self.url = URL(string: imagePath)!
    }
    
    public static func transform(unboxedValue: UnboxRawValue) -> Logo? {
        return Logo(imagePath: unboxedValue)
    }
}

extension Price: UnboxableByTransform {
    public typealias UnboxRawValue = String
    
    init?(amount: Double) {
        self.currency = .euro
        self.amount = amount
    }
    
    public static func transform(unboxedValue: UnboxRawValue) -> Price? {
        // See the discussion: https://github.com/JohnSundell/Unbox/issues/135
        let value = Double(unboxedValue)
        return Price(amount: value!)
    }
}
