//
//  ViewElementsFactory.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class ViewElementsFactory: UIKitElementsFactory {

    override func element(for xmlNode: XMLNode) throws -> ElementType {
        switch xmlNode.name {
            case "subviews":
                return try SubviewsElement(from: xmlNode)

            default:
                return try super.element(for: xmlNode)
        }
    }
}
