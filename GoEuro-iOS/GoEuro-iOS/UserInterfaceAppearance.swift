//
//  UserInterfaceAppearance.swift
//  GoEuro-iOS
//
//  Created by Evgen Dubinin on 10/25/16.
//  Copyright © 2016 GoEuro. All rights reserved.
//

import Foundation

import UIKit

// MARK: Common View Controller Appearance -

// Note: This is a direct mapping between plain parameters one might
// want to customize and their direct application to the "real" properties

protocol ViewControllerAppearance {
    var navigationBarBackgroundColor: UIColor { get }
    var navigationBarTitleColor: UIColor { get }
    var navigationBarButtonsColor: UIColor { get }
    var navigationBarTitleFont: UIFont { get }
}

struct DefaultViewControllerAppearance: ViewControllerAppearance {
    var navigationBarBackgroundColor = UIColor.goeuroBlue
    var navigationBarTitleColor = UIColor.goeuroWhite
    var navigationBarTitleFont = UIFont.goeuroScreenTitleFont()
    var navigationBarButtonsColor = UIColor.goeuroWhite
}

protocol ViewControllerAppearanceCustomizable {
    // In order to make everything work, this should be called in
    // -viewDidLayoutSubviews()
    func applyCustom(_ appearance: ViewControllerAppearance)
}

extension ViewControllerAppearanceCustomizable where Self: UIViewController {
    func applyCustom(_ appearance: ViewControllerAppearance) {
        self.navigationController?.navigationBar.tintColor = appearance.navigationBarButtonsColor
        self.navigationController?.navigationBar.barTintColor = appearance.navigationBarBackgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : appearance.navigationBarTitleColor,
                                                                        NSAttributedString.Key.font : appearance.navigationBarTitleFont]
        self.navigationController?.navigationBar.isTranslucent = false
    }
}
