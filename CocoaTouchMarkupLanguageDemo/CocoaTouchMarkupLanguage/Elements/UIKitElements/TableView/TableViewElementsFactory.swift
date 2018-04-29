//
//  TableViewElementsFactory.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 29/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class TableViewElementsFactory: ViewElementsFactory {

    override func element(for xmlNode: XMLNode) throws -> ElementType {
        switch xmlNode.name {
            case "prototypes":
                return try TableViewPrototypesElement(from: xmlNode)

            case "tableViewCell":
                return try TableViewCellPrototypeElement(from: xmlNode)

            default:
                return try super.element(for: xmlNode)
        }
    }
}
