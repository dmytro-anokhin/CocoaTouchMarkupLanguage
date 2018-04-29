//
//  UIView+String.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


extension UIViewContentMode: CustomStringConvertible {

    public var description: String {
        switch self {
            case .scaleToFill:
                return "scaleToFill"
            case .scaleAspectFit:
                return "scaleAspectFit"
            case .scaleAspectFill:
                return "scaleAspectFill"
            case .redraw:
                return "redraw"
            case .center:
                return "center"
            case .top:
                return "top"
            case .bottom:
                return "bottom"
            case .left:
                return "left"
            case .right:
                return "right"
            case .topLeft:
                return "topLeft"
            case .topRight:
                return "topRight"
            case .bottomLeft:
                return "bottomLeft"
            case .bottomRight:
                return "bottomRight"
        }
    }
}

extension UIViewContentMode {

    public init?(string: String) {
        #if swift(>=4.2)
            // Swift 4.2 supposed to implement "Derived Collection of Enum Cases"
            // #error https://github.com/apple/swift-evolution/blob/master/proposals/0194-derived-collection-of-enum-cases.md
            // #warning
        #else
            switch string.lowercased() {
                case String(describing: UIViewContentMode.scaleToFill).lowercased():
                    self = .scaleToFill
                case String(describing: UIViewContentMode.scaleAspectFit).lowercased():
                    self = .scaleAspectFit
                case String(describing: UIViewContentMode.scaleAspectFill).lowercased():
                    self = .scaleAspectFill
                case String(describing: UIViewContentMode.redraw).lowercased():
                    self = .redraw
                case String(describing: UIViewContentMode.center).lowercased():
                    self = .center
                case String(describing: UIViewContentMode.top).lowercased():
                    self = .top
                case String(describing: UIViewContentMode.bottom).lowercased():
                    self = .bottom
                case String(describing: UIViewContentMode.left).lowercased():
                    self = .left
                case String(describing: UIViewContentMode.right).lowercased():
                    self = .right
                case String(describing: UIViewContentMode.topLeft).lowercased():
                    self = .topLeft
                case String(describing: UIViewContentMode.topRight).lowercased():
                    self = .topRight
                case String(describing: UIViewContentMode.bottomLeft).lowercased():
                    self = .bottomLeft
                case String(describing: UIViewContentMode.bottomRight).lowercased():
                    self = .bottomRight
                default:
                    return nil
            }
        #endif
    }
}
