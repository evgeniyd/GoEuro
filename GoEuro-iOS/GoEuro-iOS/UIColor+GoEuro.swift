//
//  UIColor+GoEuro.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import UIKit

extension UIColor {
    public static var goeuroBlue: UIColor {
        return UIColor.init(red: (48.0/255.0), green: (124.0/255.0), blue: (246.0/255.0), alpha: 1.0)
    }
    
    public static var goeuroWhite: UIColor {
        return UIColor.white // just in case, the black would become a new white :)
    }
    
    public static var goeuroGray: UIColor {
        return UIColor.init(red: (128.0/255.0), green: (128.0/255.0), blue: (128.0/255.0), alpha: 1.0)
    }
    
    public static var goeuroLightgrey: UIColor {
        return UIColor.init(red: (211.0/255.0), green: (211.0/255.0), blue: (211.0/255.0), alpha: 1.0)
    }
}
