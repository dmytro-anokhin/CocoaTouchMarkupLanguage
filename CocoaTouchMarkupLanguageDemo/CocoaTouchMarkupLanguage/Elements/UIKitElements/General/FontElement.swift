//
//  FontElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import UIKit

class FontElement: Element, PropertyElementType {

    private var _font: UIFont?

    var font: UIFont? {
        if _font == nil {
            _font = loadFont()
        }

        return _font
    }

    var value: Any? {
        return font
    }

    private func loadFont() -> UIFont? {
        guard let pointSizeString = attributes["pointSize"],
              let pointSize = CGFloat(pointSizeString)
        else {
            assertionFailure("Font element must contain pointSize attribute")
            return nil
        }

        if let type = attributes["type"] {
            switch type {
                case "system":
                    return UIFont.systemFont(ofSize: pointSize)
                case "boldSystem":
                    return UIFont.boldSystemFont(ofSize: pointSize)
                default:
                    assertionFailure("Font element unknown type: \(type)")
            }
        }

        guard let name = attributes["name"],
              let family = attributes["family"]
        else {
            assertionFailure("Font element must have type or name/family attributes")
            return nil
        }

        let fontDescriptor = UIFontDescriptor(fontAttributes: [ .family : family, .name : name ])

        return UIFont(descriptor: fontDescriptor, size: pointSize)
    }
}
