//
//  TableViewPrototypesElement.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class TableViewPrototypesElement: Element {

    override class var factory: ElementsFactoryType {
        return TableViewElementsFactory()
    }

    required init(from xmlNode: XMLNode) throws {
        try super.init(from: xmlNode)
    }

    public required init(name: String, children: [ElementType], attributes: [String : String]) {
        super.init(name: name, children: children, attributes: attributes)
    }
}
