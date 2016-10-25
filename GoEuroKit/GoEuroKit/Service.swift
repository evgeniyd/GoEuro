//
//  Service.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation
import Result
import Unbox

////////////////////////////////////
// MARK: Support Types -
////////////////////////////////////

public typealias ServiceActionBody = [String: String]

public enum TransferProtocol: String {
    case http, https
}

public enum ServiceActionMethod: String {
    case GET, POST // ... add more
}

////////////////////////////////////
// MARK: Main Service Protocols -
////////////////////////////////////

public protocol ServiceProtocol {
    var transferProtocol: TransferProtocol { get }
    var basePath: String { get }
    var apiKey: String { get }
    var actionPath: String { get }
    var actionBody: ServiceActionBody? { get }
    var actionMethod: ServiceActionMethod { get }
}

////////////////////////////////////
// MARK: ServiceProtocol Default -
////////////////////////////////////

extension ServiceProtocol { // ???: Do we need some constraints to this proto extension?
    public var transferProtocol: TransferProtocol {
        get { return .https }
    }
    
    public var basePath: String {
        get { return "api.myjson.com/bins/" }
    }
    
    public var apiKey: String {
        get { return "" }
    }
    
    public var actionPath: String {
        get { return "" }
    }
    
    public var actionBody: ServiceActionBody? {
        get { return nil }
    }
    
    public var actionMethod: ServiceActionMethod {
        get { return .GET }
    }
}

////////////////////////////////////
// MARK: Requestable -
////////////////////////////////////

public protocol Requestable {
    associatedtype Value
    associatedtype Error: GoEuroKitError
    
    var request: URLRequest { get }
    func requestWith(_ completion: @escaping (Result<Value, Error>) -> Void)
}

////////////////////////////////////
// MARK: Requestable Default -
////////////////////////////////////

extension Requestable where Self: ServiceProtocol {
    public var request: URLRequest {
        get  {
            var requestPath: String = "\(self.transferProtocol)://" + basePath + actionPath
            if !apiKey.isEmpty { requestPath += "?api_key=\(apiKey)" }
            if let actionBody = self.actionBody {
                for (paramKey, paramValue) in actionBody {
                    requestPath.append("&\(paramKey)=\(paramValue)")
                }
            }
            return URLRequest(url: NSURL(string: requestPath)! as URL)
            // TODO: request.HTTPMethod = .POST
        }
    }
}
