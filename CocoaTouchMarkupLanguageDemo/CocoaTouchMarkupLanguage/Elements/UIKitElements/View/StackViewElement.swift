//
//  StackViewElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


class StackViewElement: ViewElement {

    override var viewClass: UIView.Type {
        return objectClass as? UIStackView.Type ?? UIStackView.self
    }

    override func applyAttribute(_ name: String, value: String, view: UIView) {
        switch name {
            case "axis":
                guard let axis = UILayoutConstraintAxis(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                (view as! UIStackView).axis = axis

            case "distribution":
                guard let distribution = UIStackViewDistribution(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                (view as! UIStackView).distribution = distribution

            case "alignment":
                guard let alignment = UIStackViewAlignment(string: value) else {
                    print("Unknown value `\(value)` for `\(name)`")
                    return
                }

                (view as! UIStackView).alignment = alignment

            default:
                super.applyAttribute(name, value: value, view: view)
        }
    }
}

