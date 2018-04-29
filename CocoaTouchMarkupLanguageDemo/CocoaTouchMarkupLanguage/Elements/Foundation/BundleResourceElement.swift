//
//  BundleResourceElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//

import Foundation


class BundleResourceElement: Element, PropertyElementType {

    var value: Any? {
        return url
    }

    var url: URL? {
        guard let name = attributes["name"] else {
            assertionFailure("Bundle resource element requires resource name attribute")
            return nil
        }

        let fileExtension = attributes["extension"]

        return Bundle.main.url(forResource: name, withExtension: fileExtension)
    }
}
