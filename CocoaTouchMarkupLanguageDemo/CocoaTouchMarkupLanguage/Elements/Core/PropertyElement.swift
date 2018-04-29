//
//  PropertyElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


/** The `PropertyElement` represents a property of an object.

    The property element should have a key attribute defined.

    <string key="text">Hello, world!</string>
*/
class PropertyElement: Element, PropertyElementType {

    var value: Any?
}
