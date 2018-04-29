//
//  SubviewsElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class SubviewsElement: Element {

    override class var factory: ElementsFactoryType {
        return ViewElementsFactory()
    }

    required init(from xmlNode: XMLNode) throws {
        try super.init(from: xmlNode)
    }

    public required init(name: String, children: [ElementType], attributes: [String : String]) {
        super.init(name: name, children: children, attributes: attributes)
    }
}
