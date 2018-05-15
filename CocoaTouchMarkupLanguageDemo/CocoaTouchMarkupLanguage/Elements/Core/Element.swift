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

    public required init(children: [ElementType], attributes: [String: String]) {
        self.children = children
        self.attributes = attributes
    }

    // MARK: ElementType

    public let children: [ElementType]

    public let attributes: [String: String]

    public var instance: Any? {
        if _instance == nil {
            _instance = load()
        }

        return _instance
    }

    // MARK: XMLDecodable

    public required init(from xmlNode: XMLNode) throws {

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

    // MARK: Loading

    private var _instance: Any?

    func load() -> Any? {
        guard let instance = instantiate() else {
            assertionFailure("Instance not instantiated: \(self)")
            return nil
        }

        for attribute in attributes {
            if Keywords.contains(attribute.key) {
                continue
            }

            applyAttribute(name: attribute.key, value: attribute.value, instance: instance)
        }

        for child in children {
            processChild(child, instance: instance)
        }

        return instance
    }

    func instantiate() -> Any? {
        return nil
    }

    // MARK: Creation and Configuration

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

    func processChild(_ child: ElementType, instance: Any) {
        switch child {
            case let property as ElementType & PropertyElementType:
                applyProperty(property, instance: instance)

            default:
                print("Child not supported \(child)")
        }
    }

    func applyAttribute(name: String, value: String, instance: Any) {
        guard let keyValueCoding = instance as? KeyValueCoding else {
            assertionFailure("Instance does not support key-value coding: \(instance)")
            return
        }

        objc_do(try: {
                keyValueCoding.setValue(value, forKey: name)
            }, catch: { exception in
                print(String(describing: exception))
            })
    }

    func applyProperty(_ property: ElementType & PropertyElementType, instance: Any) {
        guard let key = property.key else {
            assertionFailure("Property element expected to have a key: \(property)")
            return
        }

        guard let keyValueCoding = instance as? KeyValueCoding else {
            assertionFailure("Instance does not support key-value coding: \(instance)")
            return
        }

        objc_do(try: {
                keyValueCoding.setValue(property.value, forKey: key)
            }, catch:{ exception in
                print(String(describing: exception))
            })
    }
}
