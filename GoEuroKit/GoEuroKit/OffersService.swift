//
//  OffersService.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation
import Result
import Unbox

public enum OffersServiceTransportation: String {
    case flight = "w60i"
    case train = "37yzm"
    case bus = "3zmcy"
}

public class OffersService: ServiceProtocol, Requestable {
    
    public init() { }
    
    public let actionPath = OffersServiceTransportation.flight.rawValue
    
    public typealias Value = OfferList
    public typealias Error = ServiceError
    
    public func requestWith(_ completion: @escaping (Result<Value, Error>) -> Void) {
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = defaultSession.dataTask(with: self.request) {(data, response, error) -> Void in
            if let data = data {
                do {
                    // DEBUG
                    var datastring = String(data: data, encoding: String.Encoding.utf8)
                    print(datastring)
                    
                    let offerList: OfferList = try unbox(data: data)
                    completion(.success(offerList))
                } catch let unboxError {
                    print(unboxError.localizedDescription)
                    completion(.failure(.parser)) // TODO: better error handling
                }
            } else if let networkError = error {
                print(networkError.localizedDescription)
                completion(.failure(.noData)) // TODO: better error handling
            }
        }
        dataTask.resume()
    }
}
