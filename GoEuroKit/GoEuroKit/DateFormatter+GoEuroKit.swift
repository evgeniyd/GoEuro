//
//  DateFormatter+GoEuroKit.swift
//  GoEuroKit
//
//  Created by Evgen Dubinin on 10/24/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func goEuroDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter
    }
}
