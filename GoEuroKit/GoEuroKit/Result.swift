//
//  Result.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/23/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

//enum Result<T, E: NSError> {
//    case success(T)
//    case failure(E)
//}

enum Result<T>
{
    case success(T)
    case failure(NSError)
}
