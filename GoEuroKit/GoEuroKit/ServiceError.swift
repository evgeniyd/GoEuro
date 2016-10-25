//
//  ServiceError.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

public protocol GoEuroKitError: Error {
}

// TODO: for now, just stick with simple error handling
public enum ServiceError: GoEuroKitError {
    case unknown
    case noData
    case parser
}
