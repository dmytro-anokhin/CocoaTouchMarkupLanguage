//
//  UIStackView+String.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


extension UIStackViewDistribution: CustomStringConvertible {

    public var description: String {
        switch self {
            case .fill:
                return "fill"
            case .fillEqually:
                return "fillEqually"
            case .fillProportionally:
                return "fillProportionally"
            case .equalSpacing:
                return "equalSpacing"
            case .equalCentering:
                return "equalCentering"
        }
    }
}


extension UIStackViewDistribution {

    public init?(string: String) {
        #if swift(>=4.2)
            // Swift 4.2 supposed to implement "Derived Collection of Enum Cases"
            // #error https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md
            // #warning
        #else
            switch string.lowercased() {
                case String(describing: UIStackViewDistribution.fill).lowercased():
                    self = .fill
                case String(describing: UIStackViewDistribution.fillEqually).lowercased():
                    self = .fillEqually
                case String(describing: UIStackViewDistribution.fillProportionally).lowercased():
                    self = .fillProportionally
                case String(describing: UIStackViewDistribution.equalSpacing).lowercased():
                    self = .equalSpacing
                case String(describing: UIStackViewDistribution.equalCentering).lowercased():
                    self = .equalCentering
                default:
                    return nil
            }
        #endif
    }
}


extension UIStackViewAlignment {

    public init?(string: String) {
        #if swift(>=4.2)
            // Swift 4.2 supposed to implement "Derived Collection of Enum Cases"
            // #error https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md
            // #warning
        #else

            // UIStackViewAlignment enum is different from UIStackViewDistribution and UILayoutConstraintAxis, where using CustomStringConvertible is possible.
            // UIStackViewAlignment has `top` and `bottom` cases defined as var making them indistinguishable from `leading` and `trailing`

            switch string.lowercased() {
                case "fill":
                    self = .fill
                case "leading":
                    self = .leading
                case "top":
                    self = .top
                case "firstbaseline":
                    self = .firstBaseline
                case "center":
                    self = .center
                case "trailing":
                    self = .trailing
                case "bottom":
                    self = .bottom
                case "lastbaseline":
                    self = .lastBaseline
                default:
                    return nil
            }

        #endif
    }
}
