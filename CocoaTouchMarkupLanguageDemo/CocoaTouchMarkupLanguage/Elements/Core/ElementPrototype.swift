//
//  ElementPrototype.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class ElementPrototype: ElementType, XMLDecodable {

    public var name: String {
        return xmlNode.name
    }

    public var children: [ElementType] {
        return xmlNode.children.map { try! ElementPrototype(from: $0) }
    }

    public var attributes: [String: String] {
        return xmlNode.attributes
    }

    public required init(from xmlNode: XMLNode) throws {
        self.xmlNode = xmlNode
    }

    private let xmlNode: XMLNode

    var elementClass: Element.Type {
        return Element.self
    }

    final func makeElement() throws -> Element {
        return try elementClass.init(from: xmlNode)
    }
}
