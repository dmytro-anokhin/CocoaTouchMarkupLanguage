//
//  KeyValueArgument.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 01/05/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


func argumentsDictionary(for element: Element, objectController: ObjectController) -> [String: Any] {

    var result: [String: Any] = [:]

    for case let argument as ArgumentElement in element.children {
        guard let name = argument.attributes["name"],
            argument.attributes["value"] == nil || argument.attributes["keyPath"] == nil
        else {
            assertionFailure("Argument \(argument) must contain name and value or keyPath")
            continue
        }

        if let value = argument.attributes["value"] {
            result[name] = value
            continue
        }

        if let keyPath = argument.attributes["keyPath"] {
            if let value = objectController.value(forKey: keyPath) {
                result[name] = value
            }
            
            continue
        }
    }

    return result
}
