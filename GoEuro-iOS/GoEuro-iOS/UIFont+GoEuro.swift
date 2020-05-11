//
//  UIFont+GoEuro.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

import UIKit

extension UIFont {
    class func goeuroScreenTitleFont() -> UIFont {
        return UIFont.goeuroScreenTitleFont(ofSize: 20.0)
    }
    
    class func goeuroScreenTitleFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }
}
