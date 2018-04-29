//
//  ElementsFactory.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


public protocol ElementsFactoryType {

    func element(for xmlNode: XMLNode) throws -> ElementType
}


class ElementsFactory: ElementsFactoryType {

    func element(for xmlNode: XMLNode) throws -> ElementType {
        switch xmlNode.name {
            case "string":
                return try PropertyElement(from: xmlNode)

            case "bundleResource":
                return try BundleResourceElement(from: xmlNode)

            case "binding":
                return try BindingElement(from: xmlNode)

            default:
                return try Element(from: xmlNode)
        }
    }
}
