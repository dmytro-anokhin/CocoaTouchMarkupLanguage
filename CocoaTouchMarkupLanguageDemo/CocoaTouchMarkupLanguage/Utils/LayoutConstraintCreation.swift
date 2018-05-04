//
//  LayoutConstraintCreation.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 04/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


/// A helper protocol to provide single interface for UIView and UILayoutGuide when creating constraints
protocol LayoutConstraintCreation {

    var leadingAnchor: NSLayoutXAxisAnchor { get }

    var trailingAnchor: NSLayoutXAxisAnchor { get }

    var leftAnchor: NSLayoutXAxisAnchor { get }

    var rightAnchor: NSLayoutXAxisAnchor { get }

    var topAnchor: NSLayoutYAxisAnchor { get }

    var bottomAnchor: NSLayoutYAxisAnchor { get }

    var widthAnchor: NSLayoutDimension { get }

    var heightAnchor: NSLayoutDimension { get }

    var centerXAnchor: NSLayoutXAxisAnchor { get }

    var centerYAnchor: NSLayoutYAxisAnchor { get }

// Not supported by UILayoutGuide
//    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
//
//    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}


extension UIView: LayoutConstraintCreation {
}

extension UILayoutGuide: LayoutConstraintCreation {
}
