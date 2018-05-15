//
//  StackViewElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class StackViewElement: ViewElement {

    // MARK: ViewElement

    override var viewClass: UIView.Type {
        return objectClass as? UIStackView.Type ?? UIStackView.self
    }

    // MARK: Loading

    override func applyAttribute(name: String, value: String, instance: Any) {
        guard let stackView = instance as? UIStackView else {
            fatalError("Expected \(type(of: UIStackView.self)), got: \(instance)")
        }

        switch name {
            case "axis":
                guard let axis = UILayoutConstraintAxis(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                stackView.axis = axis

            case "distribution":
                guard let distribution = UIStackViewDistribution(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                stackView.distribution = distribution

            case "alignment":
                guard let alignment = UIStackViewAlignment(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                stackView.alignment = alignment

            default:
                super.applyAttribute(name: name, value: value, instance: instance)
        }
    }
}
