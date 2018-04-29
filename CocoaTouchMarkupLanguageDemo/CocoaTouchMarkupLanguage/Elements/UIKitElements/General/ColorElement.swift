//
//  ColorElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit


/** The `ColorElement` is a property element for UIColor.

    <color key="backgroundColor" red="0.2" green="0.4" blue="0.4" alpha="1.0" colorSpace="rgb"/>
*/
class ColorElement: Element, PropertyElementType {

    private var _color: UIColor?

    var color: UIColor? {
        if _color == nil {
            _color = loadColor()
        }

        return _color
    }

    var value: Any? {
        return color
    }

    private func loadColor() -> UIColor? {
        guard let colorSpace = attributes["colorSpace"] else {
            print("Color node must define colorSpace")
            return nil
        }

        switch colorSpace.lowercased() {
            case "rgb":
                guard let rString = attributes["red"], let r = CGFloat(rString),
                      let gString = attributes["green"], let g = CGFloat(gString),
                      let bString = attributes["blue"], let b = CGFloat(bString),
                      let aString = attributes["alpha"], let a = CGFloat(aString)
                else {
                    print("Color node with colorSpace=\(colorSpace) must contain red, green, blue, and alpha components as attributes")
                    return nil
                }

                let range = CGFloat(0.0)...CGFloat(1.0)

                guard range.contains(r), range.contains(b), range.contains(g), range.contains(a) else {
                    print("Color components of the color node with colorSpace=\(colorSpace) must be in [0.0, 1.0] range")
                    return nil
                }

                return UIColor(red: r, green: g, blue: b, alpha: a)

            default:
                print("Unexpected colorSpace=\(colorSpace)")
        }

        return nil
    }
}
