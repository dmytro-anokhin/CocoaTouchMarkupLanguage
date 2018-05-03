//
//  Element.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


public class Element: ElementType, XMLDecodable {

    public class var factory: ElementsFactoryType {
        return ElementsFactory()
    }

    public let name: String

    public let children: [ElementType]

    public let attributes: [String: String]

    public required init(from xmlNode: XMLNode) throws {

        self.name = xmlNode.name

        let factory = type(of: self).factory

        self.children = xmlNode.children.compactMap {
            do {
                return try factory.element(for: $0)
            }
            catch {
                print(error)
                return nil
            }
        }

        self.attributes = xmlNode.attributes
    }

    public required init(name: String, children: [ElementType], attributes: [String: String]) {
        self.name = name
        self.children = children
        self.attributes = attributes
    }

    var objectClass: AnyClass? {
        guard let className = attributes.first(where: { $0.key.lowercased() == Keywords.className.lowercased() })?.value else {
            return nil
        }

        guard let aClass = NSClassFromString(className) ?? NSClassFromString("CocoaTouchMarkupLanguage." + className) else {
            assertionFailure("Class with name `\(className)` not found")
            return nil
        }

        return aClass
    }

    func setProperty(_ property: ElementType & PropertyElementType, object: KeyValueCoding) {
        guard let key = property.key else {
            assertionFailure("Property element expected to have a key: \(property)")
            return
        }

        objc_do(try: {
                object.setValue(property.value, forKey: key)
            }, catch:{ exception in
                print(String(describing: exception))
            })
    }
}


enum ElementError: Error {

    case generic(reason: String)

    case domain(underlyingError: Error)

    case unknownClass(className: String)

    case unexpectedClass(className: String)
}
