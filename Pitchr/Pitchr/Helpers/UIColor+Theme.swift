//
//  UIColor+Theme.swift
//  Pitchr
//
//  Created by Simon Elhoej Steinmejer on 13/02/19.
//  Copyright © 2019 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

extension UIColor {
    static let appGreenOne = UIColor.rgb(red: 29, green: 140, blue: 121)
    static let appGreenTwo = UIColor.rgb(red: 63, green: 179, blue: 170)
    static let googleOrange = UIColor.rgb(red: 234, green: 67, blue: 53)
    static let facebookBlue = UIColor.rgb(red: 60, green: 90, blue: 153)
}

enum Appearance {
    static func appFont(with size: CGFloat, weight: AppFontName) -> UIFont {
        return UIFont(name: "Muli-\(weight.rawValue)", size: size)!
    }
}

extension Appearance {
    enum AppFontName: String {
        case light = "Light"
        case regular = "Regular"
        case bold = "SemiBold"
    }
}
