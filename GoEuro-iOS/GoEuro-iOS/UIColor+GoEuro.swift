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
    
    public static var goeuroLightBlue: UIColor {
        return UIColor.init(red: (128.0/255.0), green: (189.0/255.0), blue: (231.0/255.0), alpha: 1.0)
    }
    
    public static var goeuroDarkBlue: UIColor {
        return UIColor.init(red: (62.0/255.0), green: (98.0/255.0), blue: (112.0/255.0), alpha: 1.0)
    }
    
    public static var goeuroWhite: UIColor {
        return UIColor.white // just in case, the black would become a new white :)
    }
}
