//
//  ViewControllerElementsFactory.swift
//  CocoaTouchMarkupLanguage
//
//  Created by Dmytro Anokhin on 28/04/2018.
//  Copyright © 2018 Dmytro Anokhin. All rights reserved.
//


class ViewControllerElementsFactory: UIKitElementsFactory {

    override func element(for xmlNode: XMLNode) throws -> ElementType {
        switch xmlNode.name {
            case "view":
                return try ViewPrototypeElement(from: xmlNode)

            case "scrollView":
                return try ScrollViewPrototypeElement(from: xmlNode)

            case "tableView":
                return try TableViewPrototypeElement(from: xmlNode)

            case "representedObject":
                return try ObjectControllerElement(from: xmlNode)
//
//            case "tableView":
//                return try TableViewElement(from: xmlNode)
//
//            case "representedObject":
//                return try ModelElement(from: xmlNode)
//
            default:
                return try super.element(for: xmlNode)
        }
    }
}
