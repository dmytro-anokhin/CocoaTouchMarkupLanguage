//
//  UILayoutConstraintAxis+String.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


extension UILayoutConstraintAxis: CustomStringConvertible {

    public var description: String {
        switch self {
            case .horizontal:
                return "horizontal"
            case .vertical:
                return "vertical"
        }
    }
}

extension UILayoutConstraintAxis {

    public init?(string: String) {
        #if swift(>=4.2)
            // Swift 4.2 supposed to implement "Derived Collection of Enum Cases"
            // #error https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md
            // #warning
        #else
            switch string.lowercased() {
                case String(describing: UILayoutConstraintAxis.horizontal).lowercased():
                    self = .horizontal
                case String(describing: UILayoutConstraintAxis.vertical).lowercased():
                    self = .vertical
                default:
                    return nil
            }
        #endif
    }
}

