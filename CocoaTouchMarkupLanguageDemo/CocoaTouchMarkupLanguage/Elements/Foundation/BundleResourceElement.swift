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
        guard let name = attributes["name"] else {
            assertionFailure("Bundle resource element requires resource name attribute")
            return nil
        }

        let fileExtension = attributes["extension"]?.lowercased()

        guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
            assertionFailure("Bundle resource with name `\(name)`, extension `\(String(describing: fileExtension))` not found in the main bundle")
            return nil
        }

        switch fileExtension {
            case "plist":
                do {
                    let data = try Data(contentsOf: url)
                    return try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                }
                catch {
                    preconditionFailure(String(describing: error))
                }

            case "json":
                do {
                    let data = try Data(contentsOf: url)
                    return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                }
                catch {
                    preconditionFailure(String(describing: error))
                }

            default:
                assertionFailure("File extension `\(String(describing: fileExtension))` not supported for the `\(name)` bundle resource element")
        }

        return nil
    }
}
